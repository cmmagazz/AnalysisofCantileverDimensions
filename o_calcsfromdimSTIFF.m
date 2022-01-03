%% Calculate stiffness from measured dims
% CMM 2020
function closestdims=o_calcsfromdimSTIFF(dimstocalc,stiffmeasured)
%load the stiffvars
% 
% samplefolder=[pwd '\foil4-3n4Data\'];
% filename = 'foil4-3n4postcalib.csv';
% load([samplefolder filename(1:5) 'PCstiffvars' num2str(3)]) %HOW MANY PC>?

%% To calculate the stiffness given a couple dim
% % the dimensions you want to test
% dimstocalc=[1170.741605
% 587.1415356
% 544.4033302
% 316.5263265
% 175.50979
% 64.36724566
% ]';%
% stiffmeasured=1917; %input the experimentally measured stiffness
% dimstocalc=x(1,:);
% stiffmeasured=stiffexp(1);
mu=evalin('base','mu');
eigenvectors=evalin('base','eigenvectors');
w=evalin('base','w');
pcpoints=evalin('base','pcpoints');
PolynomialFormula=evalin('base','PolynomialFormula');

%convert to PC space
dimstocalcPC=bsxfun(@plus,dimstocalc,-mu)*(diag(w)*eigenvectors);

%calculate the stiffness
multiregcalcoutput(dimstocalcPC, size(pcpoints,2), PolynomialFormula)

% %visualise if it's in the space tested. 
% templot=[pcpoints; dimstocalcPC(1:size(pcpoints,2))];
% templot2=ones(size(templot,1),1);
% templot2(end+1-size(dimstocalcPC,1):end)=2;
% gplotmatrix(templot,[],templot2,[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships
% title(['PCA Calculations with PC ' num2str(size(pcpoints,2)) ', and test dim'])

% To predict dims from stiffness
% This takes the dims measured as the closest possible dims, and gives the
% dims closest to that with the stiffness provided.



PolynomialFormulavar= @(x)PolynomialFormula(x(:,1),x(:,2),x(:,3))-stiffmeasured; %define the function as the difference

[closestdimsPC,~,~,output,jacobian]= fsolve(PolynomialFormulavar, dimstocalcPC(1:3)); %find the closest dims in PC space

closestdims = closestdimsPC(:,1:3) * eigenvectors(:,1:3)'; %HARDCODED TO NUMBER OF PCs
closestdims = bsxfun(@plus, closestdims, mu);
%closestdims=closestdims'; %FOR LOOPING DONT DO THIS LINE

close all
end
%% Dealing with errors
% Instead of just doing stiffness +/- standard DEVIATION (not error), we
% can do a pretend run with 5000 random points with that same standard
% deviation, and see if the standard deviation of the output of this is the
% same as the range done before (stiffness +/- stdev). At about 5000
% points, this does seem to converge. If you do standard error as +/-, 
% then the range should also be standard error. 
%{
randstiff=normrnd(1917,1917*0.08,[5000,1]);


for i=1:5000
    PolynomialFormulavarerr= @(x)PolynomialFormula(x(:,1),x(:,2),x(:,3))-randstiff(i); %define the function as the difference

    closestdimsPCerr = fsolve(PolynomialFormulavarerr, dimstocalcPC(1:3)); %find the closest dims in PC space
    closestdimserr = closestdimsPCerr(:,1:3) * eigenvectors(:,1:3)'; %HARDCODED TO NUMBER OF PCs
    closestdimserr = bsxfun(@plus, closestdimserr, mu);
    closestdimserr=closestdimserr';
    closestdimserrtot(i,:)=closestdimserr;
end
figure()
hist(randstiff)
figure()
hist(closestdimserrtot(:,6))
closestdimserr(6)
std(closestdimserrtot(:,6))/mean(closestdimserrtot(:,6))

%%

[X,Y,Z] = meshgrid(-3:0.1:3,-3:0.1:3,-3:0.1:3);
PolynomialFormulavar= @(x)PolynomialFormula(x(:,1),x(:,2),x(:,3))-2550;
S=PolynomialFormulavar([X(:),Y(:),Z(:)]);
vizdata=[X(:),Y(:),Z(:),S(:)];
gplotmatrix(vizdata,[],[],[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships
title(['PCA Calculations with PC' num2str(size(pcpoints,2))])
%}