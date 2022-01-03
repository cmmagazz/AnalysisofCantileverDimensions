%% pca for data incoming

% Way this works: 6 total dimensions go in, and an initial plot is made to
% look at variation between individual measurements. You run PCA on the
% data, aligning all variables into their orthogonal principal components,
% giving the usual statistical weights. Hardcoded (bad) is the elimination
% down to 3 components which contain ~80% of the variation. The equations
% linking all 6 measurements to those 3 principal components is given, as
% well as the range to span them. Then, it gives the span in real space,
% showing where you're covering by covering that area, approximated (using
% the mean of the rest of the components). 
clear all
filename = 'foils7-11dimsonly.csv';
delimiter = ','; formatSpec = '%s%s%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen([pwd '\foil7t11\' filename],'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,...
    'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
n4dims = table(dataArray{1:end-1}, 'VariableNames', {'Type','Sample','A','B','C','D','E','t','quality','time','polbatch','imagbatch'});
clearvars delimiter formatSpec fileID dataArray ans;

x=table2array(n4dims(:,1:8));%FOIL 3n4
x=table2array(n4dims(:,3:10));%FOIL 7t11

xnames = {'A','B','C','D','E','t','q','time'};

x=x(:,1:6);%keep only A,B,C,D,E,t
xnames=xnames(1:6);
batch=table2array(n4dims(:,9)); %foil 3n4 
batch=table2array(n4dims(:,11)); %foil 7t11
%to if needed FORMAT IS 1,2,3 etc. for now with only 2

%Delete outlier
%
deletethisrow = 12;
x(deletethisrow,:) = [];
batch(deletethisrow,:) = [];

%} 
batch=cellstr(strcat('EP Batch: ',' ',num2str(batch)));%for ep batch
batch=names(:,2);%for materials - need names file. (e.g. foil4names.mat)

%visualise
gplotmatrix(x,[],batch,[],'+xo.',[],[],'grpbars',xnames) %show the inter-dimensional scatter / relationships
title('SEM Measurements /\mum')
%print([filename(1:9) 'THESISmatrix_EPbatch'], '-dpng','-r900')
%print([filename(1:9) 'THESISmatrix_mat'], '-dpng','-r900')
% 
% time=clock;
% print(['OMmatrix_7t11',num2str(time(1:4))],'-dpng','-r900')
% savefig(['OMmatrix_7t11', num2str(time(1:4))])
%figure()
%boxplot(x,'Orientation','horizontal','Labels',xnames)

%% the basic pca stuff
%C = corr(x,x);
w = 1./var(x); %keep weightings for forward transformations if needed
[eigenvectors,score,latent,tsquared,explained] = pca(x,'VariableWeights','variance');
coefforth = diag(std(x))\eigenvectors; % basically = inv(diag(std(x)))*eigenvectors
I = coefforth'*coefforth;
I(1:size(coefforth,1),1:size(coefforth,2)) %sanity check, make sure 1 along diagonal and 0 elsewhere

%{
figure() %plot the score of each point along the first 2 principal components
plot(score(:,1),score(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
%gname %if you want to click and see who's who
%}
figure()
pareto(explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')
title('Scree Plot')
% print([filename(1:9) 'scree'], '-dpng','-r500')
% 
% print([filename(1:9),'scree',num2str(time(1:4))],'-dpng','-r0')
% savefig([filename(1:9),'scree',num2str(time(1:4))])
%T test to find extreme outliers which would have to be ignored
%{
[st2,index] = sort(tsquared,'descend'); % find extreme outliers with Tsquared analysis
extreme = index(1); %and where they are in the data
x(extreme,:) %which data point is it? 
%}
%% applying pca, then reconstructing from select PCs

nComp =2;%keep 2 components for display purposes
Xhat = score(:,1:nComp) * eigenvectors(:,1:nComp)'; %Xhat=PCA reconstruction=PC scores*EigenvectorsT+Mean
mu = mean(x);
Xhat = bsxfun(@plus, Xhat, mu); %adding mean to each element in Xhat by row

figure()
gplotmatrix(Xhat,[],batch,[],'+xo',[],[],'grpbars',xnames) %show the inter-dimensional scatter / relationships
title(['PCA Reconstruction with PC' num2str(nComp)])


%% the linspace stuff
numbpoints=10; %number of values to calculate along each PCA direction
pclist=zeros(numbpoints,nComp);
for i=1:nComp
    pci=linspace(min(score(:,i)),max(score(:,i)),numbpoints);
    pclist(:,i)=pci;
end
if nComp==2 %there's probably a better way of doing this 
    pcpoints=combvec(pclist(:,1)',pclist(:,2)')';%for 2 PCs, combine vectors
elseif nComp==3
    pcpoints=combvec(pclist(:,1)',pclist(:,2)',pclist(:,3)')'; %for 3 PCs..
elseif nComp==4
    pcpoints=combvec(pclist(:,1)',pclist(:,2)',pclist(:,3)',pclist(:,4)')'; %for 4 PCs..
elseif nComp==5
    pcpoints=combvec(pclist(:,1)',pclist(:,2)',pclist(:,3)',pclist(:,4)',pclist(:,5)')'; 
elseif nComp==6
    pcpoints=combvec(pclist(:,1)',pclist(:,2)',pclist(:,3)',pclist(:,4)',pclist(:,5)',pclist(:,6)')';
end

%plot the linspaced points on the first two principal components
%{
figure()
plot(score(:,1),score(:,2),'+')
hold on
plot(pcpoints(:,1),pcpoints(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
%}
%%
%dim points = the PCA space points transformed into real space
dimpoints = pcpoints(:,1:nComp) * eigenvectors(:,1:nComp)';
dimpoints = bsxfun(@plus, dimpoints, mu);
%SANITY: 
dimpoints=abs(dimpoints);
toclear=dimpoints(:,6)<10;
pcpoints(toclear,:)=[];
dimpoints(toclear,:)=[];

forplottin=[x; dimpoints]; %for plotting, stack all into one big array
forplottinbatch=[batch; ones(size(dimpoints,1),1)*(1+max(batch))];

forplottinbatch2 = num2cell(forplottinbatch);
forplottinbatch2(forplottinbatch <(1+max(batch))) = {'Original Measurements'};
forplottinbatch2(forplottinbatch == (1+max(batch))) = {sprintf('Test points with %d PCs',nComp)};
forplottinbatch2=cellstr(forplottinbatch2);
forplottinbatch=forplottinbatch2; clear forplottinbatch2

gplotmatrix(forplottin,[],forplottinbatch,'kr','.+',[],[],'grpbars',xnames) %show the inter-dimensional scatter / relationships
title(['Original Measurements (\mum) ',sprintf('and test points based on %d PC', nComp)])
% 
% print(['OMmatrix_3n4AND2PC',num2str(time(1:4))],'-dpng','-r0')
% savefig(['OMmatrix_3n4AND2PC', num2str(time(1:4))])
%
%%
print([filename(1:9) 'PC' num2str(nComp) 'gplotmatrix'], '-dpng','-r500')

csvwrite(['dimensionstotest_PC' num2str(nComp) '.csv'],dimpoints) %csv file written with the new dimensional data
%% the linspace stuff - all, like an optimised version of the first run on abaqus
%{
numberComp=6;
numbpoints=3;
pclist=zeros(numbpoints,numberComp);
for i=1:numberComp
    pci=linspace(min(score(:,i)),max(score(:,i)),numbpoints);
    pclist(:,i)=pci;
end
pcpoints=combvec(pclist(:,1)',pclist(:,2)',pclist(:,3)',pclist(:,4)',pclist(:,5)',pclist(:,6)')';

%plot the linspaced points on the first two principal components
%{

plot(score(:,1),score(:,2),'+')
hold on
plot(pcpoints(:,1),pcpoints(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
%}
dimpoints = pcpoints(:,1:numberComp) * eigenvectors(:,1:numberComp)';
dimpoints = bsxfun(@plus, dimpoints, mu);

%dimpoints(1,:)
%gplotmatrix(Xhat2,[],[],[],'+xo',[],[],'grpbars',xnames) %show the inter-dimensional scatter / relationships


forplottin=[X; dimpoints]; %for plotting, stack all into one big array
forplottinbatch=[batch; ones(size(pcpoints,1),1)*3];

forplottinbatch2 = num2cell(forplottinbatch);
forplottinbatch2(forplottinbatch == 1) = {'Batch 1'};
forplottinbatch2(forplottinbatch == 2) = {'Batch 2'};
forplottinbatch2(forplottinbatch == 3) = {sprintf('Test points with %d PCs',numberComp)};
forplottinbatch2=cellstr(forplottinbatch2);
forplottinbatch=forplottinbatch2; clear forplottinbatch2

gplotmatrix(forplottin,[],forplottinbatch,[],'+xo',[],[],'grpbars',xnames) %show the inter-dimensional scatter / relationships
title(sprintf('Original dataset matrix, and test points based on %d PC', numberComp))

%}

%% saving the right variables
%saving variables: pcpoints, mu, scores, eigenvectors, w
%
save([filename(1:9) 'PCAvars' num2str(nComp)],'pcpoints', 'mu', 'score', 'eigenvectors', 'w','filename','n4dims')
clearvars -except filename nComp
close all
load([filename(1:9) 'PCAvars' num2str(nComp)],'pcpoints', 'mu', 'score', 'eigenvectors', 'w','filename','n4dims')
%}