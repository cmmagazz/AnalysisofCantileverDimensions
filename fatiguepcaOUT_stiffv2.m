%% pca OUT
% Way this works: the input data is a list of all the tested principal
% components, their respective real space dimensions, and the stiffness
% output. 
% Stiffness matrix has load and displacement at the end, so make an
% actual stiffness table
% UPDATED in order to allow for higher number of PCs

samplefolder=[pwd '\foil7t11\'];
outputname='stiffnesspostcalib_7-11_PC3';
%varsname='foil4PCAvars3.mat';
varsname=[pwd '\foil7t11\foils7-11PCAvars3.mat'];

try
    stiffness=load([outputname '.mat']);
catch
    stiffness=load([samplefolder outputname '.mat']);
end
load(varsname)
%load('closestdims.mat')
stiffness=stiffness.stiffness; %shenanigans with loading

stiffnessonly(:,1:6)=stiffness(:,1:6);
stiffnessonly(:,7)=stiffness(:,9);
gplotmatrix(stiffnessonly,[],[],[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships
title(['PCA Calculations with PC' num2str(size(pcpoints,2))])
print([filename(1:5) 'PC' num2str(size(pcpoints,2)) 'gplotmatrixstiff'], '-dpng','-r500')

clearvars stiffnessonly

% To transform points forward to PC coordinates/space, need to perform: 
% pcpoints = bsxfun(@plus,points to move, mean of original dataset) *
% diag(weights)*eigenvectors
% This isn't strictly necessary: we have the original pcpoints from before,
% but it's worth checking for learning. 
%pcpointseasy=bsxfun(@plus,dimpoints,-mu)*(diag(w)*eigenvectors);
% and it's correct!


%% Fitting section
%Using the MultiPolyRegress function that I found
addpath(genpath('Z:\CM\GitHub\MultiPolyRegress-MatlabCentral'))
%Need the following syntax: reg=MultiPolyRegress(X,Y,2) % Gives you the fit.
% X is mxn where m is number of points, n is number of dims. Y is mx1.
% final variable is the dimensionality of the fit.
reg=MultiPolyRegress(pcpoints,stiffness(:,9),2);

PolynomialFormula=reg.PolynomialExpression;
disp(['R squared: ', num2str(reg.RSquare)])

% I removed the visualisation as it's gonna be pointless for higher PCs.
% See v1 if you need it.

%% Calculating stiffness of samples
stiffsamples2=table2array(n4dims);
stiffsamples2=stiffsamples2(:,3:8);
stiffsamples2=double(stiffsamples2);
% Using the previous code to re-translate the original coordinates
% (including outliers)
allscores=bsxfun(@plus,stiffsamples2,-mu)*(diag(w)*eigenvectors);
% and save the calculated stiffness in that matrix in an extra column

stiffsamples2(:,size(stiffsamples2,2)+1)=multiregcalcoutput(allscores, size(pcpoints,2), PolynomialFormula);
disp(['Stiffnesses saved in stiffsamples2 under column ' num2str(size(stiffsamples2,2))])
%% sensitivity things
meangeom=mean(stiffsamples2(:,1:6));%define the mean geometry of all samples
meanofall_scores=bsxfun(@plus,meangeom,-mu)*(diag(w)*eigenvectors); %that, but in PC space

stiffmean=multiregcalcoutput(meanofall_scores, size(pcpoints,2), PolynomialFormula); %find the mean resfreq

sensitivity1um=bsxfun(@plus,(meangeom-eye(size(meangeom,2))),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1um=stiffmean-multiregcalcoutput(sensitivity1um, size(pcpoints,2), PolynomialFormula);
sensitivity1um=sensitivity1um';

sensitivity1pc=bsxfun(@plus,(meangeom-(eye(size(meangeom,2)).*0.01).*meangeom),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1pc=stiffmean-multiregcalcoutput(sensitivity1pc, size(pcpoints,2), PolynomialFormula);
sensitivity1pc=sensitivity1pc';

save([samplefolder filename(1:9) 'PCstiffvarstest' num2str(size(pcpoints,2))])
