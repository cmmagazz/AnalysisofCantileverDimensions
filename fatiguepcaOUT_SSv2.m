%% pca OUT
% Way this works: the input data is a list of all the tested principal
% components, their respective real space dimensions, and the stiffness
% output. 
% Stiffness matrix has load and displacement at the end, so make an
% actual stiffness table
samplefolder=[pwd '\foil4-3n4Data\'];
outputname='steadystatepostcalib_PC3';
varsname='foil4PCAvars3.mat';
try
    SSstressregression=load([samplefolder outputname '.mat']);
catch
    SSstressregression=load([outputname '.mat']);
end
load(varsname)
SSstressregression=SSstressregression.SSstressregression;

gplotmatrix(SSstressregression,[],[],[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships
title(['PCA Calculations with PC' num2str(size(pcpoints,2))])
print([filename(1:5) 'PC' num2str(size(pcpoints,2)) 'gplotmatrixSS'], '-dpng','-r500')



%% Fitting section
%Using the MultiPolyRegress function that I found
addpath(genpath('Z:\CM\GitHub\MultiPolyRegress-MatlabCentral'))
%Need the following syntax: reg=MultiPolyRegress(X,Y,2) % Gives you the fit.
% X is mxn where m is number of points, n is number of dims. Y is mx1.
% final variable is the dimensionality of the fit.
reg=MultiPolyRegress(pcpoints,SSstressregression(:,7),2);

PolynomialFormula=reg.PolynomialExpression;
disp(['R squared: ', num2str(reg.RSquare)])

% I removed the visualisation as it's gonna be pointless for higher PCs.
% See v1 if you need it.

%% Calculating stiffness of samples
SSstressregressionsamples=table2array(n4dims);
SSstressregressionsamples=SSstressregressionsamples(:,1:6);
% Using the previous code to re-translate the original coordinates
% (including outliers)
allscores=bsxfun(@plus,SSstressregressionsamples,-mu)*(diag(w)*eigenvectors);
% and save the calculated stiffness in that matrix in an extra column

SSstressregressionsamples(:,size(SSstressregressionsamples,2)+1)=multiregcalcoutput(allscores, size(pcpoints,2), PolynomialFormula);
disp(['SS saved in SSstressregressionsamples under column ' num2str(size(SSstressregressionsamples,2))])


%% sensitivity things
meangeom=mean(SSstressregressionsamples(:,1:6));%define the mean geometry of all samples
meanofall_scores=bsxfun(@plus,meangeom,-mu)*(diag(w)*eigenvectors); %that, but in PC space

stressmean=multiregcalcoutput(meanofall_scores, size(pcpoints,2), PolynomialFormula); %find the mean resfreq

sensitivity1um=bsxfun(@plus,(meangeom-eye(size(meangeom,2))),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1um=stressmean-multiregcalcoutput(sensitivity1um, size(pcpoints,2), PolynomialFormula);
sensitivity1um=sensitivity1um';


sensitivity1pc=bsxfun(@plus,(meangeom-(eye(size(meangeom,2)).*0.01).*meangeom),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1pc=stressmean-multiregcalcoutput(sensitivity1pc, size(pcpoints,2), PolynomialFormula);
sensitivity1pc=sensitivity1pc';

save([samplefolder filename(1:5) 'PCstressvars'])

%% Plot the estimated values for the samples on the 3d plot
% figure('units','normalized','outerposition',[0 0 1 1])
% surf(data2X,data2Y,Fmodel)
% alpha 0.8
% hold on
% scatter3(pcpointstress(:,1),pcpointstress(:,2),pcpointstress(:,3),'filled','MarkerFaceColor',[1 0 0])
% scatter3(allscores(:,1),allscores(:,2),stresssamples2(:,8),'filled','MarkerFaceColor',[0 0 0])
% hold off
% xlabel('Coordinates in PC 1')
% legend({'Model surface', 'Test points from 2 PC''s', 'Model-estimated values for samples'})
% ylabel('Coordinates in PC 2')
% zlabel('Stress per unit angle (GPa / rad)')
% title('Stiffness of sample points and predicted stiffness from model')
% saveas(gcf,[samplefolder, 'stressmodelfigwithsamples'],'png')

%% Optional if you want to colour by position relative to resonant frequency
%Colour based on location. If it's between 19700 and 19760, red, otherwise
%green or blue, and more intense for closer.
%{
for i =1:size(resfreqsamples,1)
    if resfreqsamples(i,8)<19650
        colours(i,:)=[(19650-resfreqsamples(i,8))/19650 0 (19650-resfreqsamples(i,8))/(19650-min(resfreqsamples(:,8)))];
    elseif resfreqsamples(i,8)>19650 && resfreqsamples(i,8)<19800
        colours(i,:)=[1 0 0];
    elseif resfreqsamples(i,8)>19800
        colours(i,:)=[(resfreqsamples(i,8)-19800)/19800 (resfreqsamples(i,8)-19800)/(max(resfreqsamples(:,8))-19800) 0];
    end
end

figure()
surf(data2X,data2Y,Fmodel)
alpha 0.8
hold on
%scatter3(pcpointstress(:,1),pcpointstress(:,2),pcpointstress(:,3),[],colours,'filled')
scatter3(allscores(:,1),allscores(:,2),stresssamples2(:,8),[],colours,'filled')
hold off
xlabel('Coordinates in PC 1')
ylabel('Coordinates in PC 2')
zlabel('Stress per unit angle (GPa / rad)')
title('Stress ratio of sample points and predicted ratios from model')
saveas(gcf,[samplefolder, 'stressmodelfigwithcolours'],'png')
%}

