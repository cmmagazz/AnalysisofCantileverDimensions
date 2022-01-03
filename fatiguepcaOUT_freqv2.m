%% pca OUT
% Way this works: the input data is a list of all the tested principal
% components, their respective real space dimensions, and the frequency
% output. 
% UPDATED in order to allow for higher number of PCs

samplefolder=[pwd '\foil7t11\'];
outputname='freqpostcalib7-11_PC3';
%varsname='foil4PCAvars3.mat';
varsname=[pwd '\foil7t11\foils7-11PCAvars3.mat'];
try
    resfreq=load([outputname '.mat']);
catch
    resfreq=load([samplefolder outputname '.mat']);
end
load(varsname)
resfreq=resfreq.resfreq; %shenanigans with loading


gplotmatrix(resfreq,[],[],[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships
title(['PCA Calculations with PC' num2str(size(pcpoints,2))])
print([filename(1:5) 'PC' num2str(size(pcpoints,2)) 'gplotmatrixfreq'], '-dpng','-r500')

%% Fitting section
%Using the MultiPolyRegress function that I found
addpath(genpath('Z:\CM\GitHub\MultiPolyRegress-MatlabCentral'))
%Need the following syntax: reg=MultiPolyRegress(X,Y,2) % Gives you the fit.
% X is mxn where m is number of points, n is number of dims (NOT NUMBER OF PC). Y is mx1.
% final variable is the dimensionality of the fit.
reg=MultiPolyRegress(pcpoints,resfreq(:,7),2);

PolynomialFormula=reg.PolynomialExpression;
disp(['R squared: ', num2str(reg.RSquare)])

% I removed the visualisation as it's gonna be pointless for higher PCs.
% See v1 if you need it.

%% Calculating resfreq of samples
resfreqsamples=table2array(n4dims);
resfreqsamples=resfreqsamples(:,3:8);
%FOR USING PREDICTED GEOMETRIES: 
%resfreqsamples=closestdims;
resfreqsamples=double(resfreqsamples);
% Using the previous code to re-translate the original coordinates
% (including outliers)
allscores=bsxfun(@plus,resfreqsamples,-mu)*(diag(w)*eigenvectors);

resfreqsamples(:,size(resfreqsamples,2)+1)=multiregcalcoutput(allscores, size(pcpoints,2), PolynomialFormula);
disp(['Resfreqs saved in resfreqsamples under column ' num2str(size(resfreqsamples,2))])

%% sensitivity things
meangeom=mean(resfreqsamples(:,1:6));%define the mean geometry of all samples
meanofall_scores=bsxfun(@plus,meangeom,-mu)*(diag(w)*eigenvectors); %that, but in PC space

resfreqmean=multiregcalcoutput(meanofall_scores, size(pcpoints,2), PolynomialFormula); %find the mean resfreq

sensitivity1um=bsxfun(@plus,(meangeom-eye(size(meangeom,2))),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1um=resfreqmean-multiregcalcoutput(sensitivity1um, size(pcpoints,2), PolynomialFormula);
sensitivity1um=sensitivity1um';

sensitivity1pc=bsxfun(@plus,(meangeom+(eye(size(meangeom,2)).*0.01).*meangeom),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1pc=multiregcalcoutput(sensitivity1pc, size(pcpoints,2), PolynomialFormula)-resfreqmean;
sensitivity1pc=sensitivity1pc';

save([samplefolder filename(1:9) 'PCfreqvars'])
