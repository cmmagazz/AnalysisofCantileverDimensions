%% pca OUT
% Way this works: the input data is a list of all the tested principal
% components, their respective real space dimensions, and the stiffness
% output. 
% Stiffness matrix has load and displacement at the end, so make an
% actual stiffness table
samplefolder=[pwd '\foil7t11\'];
outputname='steadystatepostcalib7-11_PC3 30khz';
%varsname='foil4PCAvars3.mat';
varsname=[pwd '\foil7t11\foils7-11PCAvars3.mat'];
try
    SSstressregression=load([outputname '.mat']);
catch
    SSstressregression=load([samplefolder outputname '.mat']);
end
load(varsname)
%load('closestdims.mat')
%{
erroracrossfreq=SSstressregression.erroracrossfreq;
%IMPLEMENT NEXT:
%originalstressandangle=erroracrossfreq(:,3:4);
for i=1:size(erroracrossfreq,1)/2
    erroracrossfreq2(i,:)=mean(erroracrossfreq(2*i-1:2*i,:));
end
%}
SSstressregression=SSstressregression.SSstressregression;
SSstressregressionbackup=SSstressregression;
%SSstressregression=SSstressregressionbackup;
% todel=[];
% for i=1:size(SSstressregressionbackup,1)
%     if erroracrossfreq2(i,1)>30 || erroracrossfreq2(i,2)>30
%         todel=[todel i];
%     end 
% end
% todel=flip(todel);
todel=[87,4];
for i=1:size(todel,2)
    SSstressregression(todel(i),:)=[];
end

gplotmatrix(SSstressregression,[],[],[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships
title(['PCA Calculations with PC' num2str(size(pcpoints,2))])
print([filename(1:5) 'PC' num2str(size(pcpoints,2)) 'gplotmatrixSS'], '-dpng','-r500')
% 
% % For now, and convenience, let's fit things based on the PC points
clearvars pcpointstress
pcpointstemp=bsxfun(@plus,SSstressregression(:,1:6),-mu)*(diag(w)*eigenvectors);
pcpointstress(:,1:3)=pcpointstemp(:,1:3); %that, but in PC space
pcpointstress(:,4)=SSstressregression(:,end);

%% Fitting section

%a0=[[0.137870075611790,0.458826997264772,0.380086261373785,4.66255312710817,18948.1840474739,19984.6660363344,39011.5572112747,27919.9390433047,-19453.7563305288,-801.610643924848]];
a0=ones(1,10);
%from frequency, the function approximately = 19725 for:
%0=337x+788y+837z+1/3. so shoving that in here as a seed.
% a0(5)=337;
% a0(6)=788;
% a0(7)=837;
% a0(8)=1/3;
%a0=[0.173105377265255,0.405300843203723,0.413834648786850,4.57694080587639,-9.03283360313656e-05,-0.000204068764539359,-0.000214667197650646,-4.59690059782086e-05,-0.000142364350181959,-7.39571724171221e-06];


[a, ~,residual] = lsqcurvefit(@f_SSfunction,a0,pcpointstress(:,1:3),pcpointstress(:,4)); %least square
hrsq=1-sum(residual.^2)/sum((pcpointstress(:,4)-mean(pcpointstress(:,4))).^2); %1-sum squared regression/sum of squares
disp(['Model values: ', num2str(a)])
disp(['R squared: ', num2str(hrsq)])


%% Calculating stiffness of samples


%USING THE ORIGINAL DIM
stresssamples2=table2array(n4dims);
stresssamples2=stresssamples2(:,3:8);
stresssamples2=double(stresssamples2);
%FOR USING PREDICTED GEOMETRIES: 
%  stresssamples2=closestdims;

% Using the previous code to re-translate the original coordinates
% (including outliers)
allscores=bsxfun(@plus,stresssamples2,-mu)*(diag(w)*eigenvectors);
% and save the calculated stiffness in that matrix in an extra column

stresssamples2(:,size(stresssamples2,2)+1)=f_SSfunction(a,allscores);

%stresssamples2(:,size(stresssamples2,2)+1)=stresssamples2(:,size(stresssamples2,2));

disp(['Stresses saved in stresssamples2 under column ' num2str(size(stresssamples2,2))])
%% sensitivity things
meangeom=mean(stresssamples2(:,1:6));%define the mean geometry of all samples
meanofall_scores=bsxfun(@plus,meangeom,-mu)*(diag(w)*eigenvectors); %that, but in PC space

stressmean=f_SSfunction(a,meanofall_scores); %find the mean stressratio

sensitivity1um=bsxfun(@plus,(meangeom-eye(size(meangeom,2))),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1um=stressmean-f_SSfunction(a,sensitivity1um);
sensitivity1um=sensitivity1um';


sensitivity1pc=bsxfun(@plus,(meangeom+(eye(size(meangeom,2)).*0.01).*meangeom),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1pc=f_SSfunction(a,sensitivity1pc)-stressmean;
sensitivity1pc=sensitivity1pc';

save([samplefolder filename(1:9) 'PCstressvars'])

%validation:

pcpointstemp=bsxfun(@plus,SSstressregressionbackup(:,1:6),-mu)*(diag(w)*eigenvectors);
clearvars pcpointstress2
pcpointstress2(:,1:3)=pcpointstemp(:,1:3); %that, but in PC space

pcpointstress2(:,4)=f_SSfunction(a,pcpointstress2(:,1:3));
scatter(SSstressregressionbackup(:,7),pcpointstress2(:,4))
gplotmatrix([SSstressregressionbackup,pcpointstress2],[],[],[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships

%% the function 
%now moved to new file