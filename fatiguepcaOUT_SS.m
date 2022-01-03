%% pca OUT
% Way this works: the input data is a list of all the tested principal
% components, their respective real space dimensions, and the stiffness
% output. 
% Stiffness matrix has load and displacement at the end, so make an
% actual stiffness table
samplefolder=[pwd '\foil4-3n4Data\'];
SSstress=load([samplefolder 'maxstress_OPT2PC43.mat']);
SSstress=SSstress.maxstress2; %shenanigans with loading

hold on
plot(olddata(:,1),olddata(:,2))

olddata=[
[1.42E-01,	4.61E+08]
[2.78E-01,	9.21E+08]
[2.11E-01,	6.91E+08]
[5.19E-01,	1.84E+09]
[7.08E-01,	2.76E+09]
[8.51E-01,	3.68E+09]
[9.79E-01,	4.80E+09]
[1.04E+00,	5.53E+09]
[1.11E+00,	6.45E+09]
[1.16E+00,	7.37E+09]];


gplotmatrix(SSstressregression,[],[],[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships


% To transform points forward to PC coordinates/space, need to perform: 
% pcpoints = bsxfun(@plus,points to move, mean of original dataset) *
% diag(weights)*eigenvectors
% This isn't strictly necessary: we have the original pcpoints from before,
% but it's worth checking for learning. 
%pcpointseasy=bsxfun(@plus,dimpoints,-mu)*(diag(w)*eigenvectors);
% and it's correct!


% For now, and convenience, let's fit things based on the PC points
clearvars pcpointstress
SSstressregression(:,7)=SSstressregression(:,7)/1e9; %work in GPa/rad
pcpointstress(:,1:2)=pcpoints(:,1:2);
pcpointstress(:,3)=SSstressregression(:,7);
pcpfx=gridify_vector(pcpointstress(:,1),10,10);
pcpfy=gridify_vector(pcpointstress(:,2),10,10);
pcpfS=gridify_vector(pcpointstress(:,3),10,10);
contourf(pcpfx,pcpfy,pcpfS,45,'LineColor','None') %visualise
scatter3(pcpointstress(:,1),pcpointstress(:,2),pcpointstress(:,3),'filled','MarkerFaceColor',[1 0 0])

todel=flip(todel);
for i=1:size(todel,2)
    deletethisrow = todel(i);
    SSstressregression(deletethisrow,:) = [];
    pcpointstress(deletethisrow,:) = [];
end
%deletethisrow = 59;
%SSstressregression(deletethisrow,:) = [];
%pcpointstress(deletethisrow,:) = [];

%% Fitting section
firstorsecondorder=1;

if firstorsecondorder==1
    a0 = ones(1,3);
    a0=a0;
    a0(3)= mean(pcpointstress(:,3));
elseif firstorsecondorder==2
    a0 = ones(1,6);
    a0=a0;
    a0(3)= mean(pcpointstress(:,3));
elseif firstorsecondorder==3
    a0 = ones(1,10);
    a0=a0;
    a0(3)= mean(pcpointstress(:,3));
elseif firstorsecondorder==4
    a0 = ones(1,15);
    a0=a0;
    a0(3)= mean(pcpointstress(:,3));
elseif firstorsecondorder==5
    a0 = ones(1,8);
    a0=a0;
    a0(1)=a0(1)/15;
    a0(2)=a0(2)/30;
    a0(3)= mean(pcpointstress(:,3));
    a0(4:7)=1;
    a0(4)=4;
    a0(5)=a0(6);
    a0(8)=2.5;
end

%turn into column of data and remove nan
xdata = pcpointstress(:,1:2);

[a, ~,residual] = lsqcurvefit(@myfun,a0,xdata,pcpointstress(:,3)); %least square
hrsq=1-sum(residual.^2)/sum((pcpointstress(:,3)-mean(pcpointstress(:,3))).^2); %1-sum squared regression/sum of squares
disp(['Model values: ', num2str(a)])
disp(['R squared: ', num2str(hrsq)])

sizemesh=50;
[data2X,data2Y] = meshgrid(min(xdata(:,1)):range(xdata(:,1))/sizemesh:max(xdata(:,1)),...
    min(xdata(:,2)):range(xdata(:,2))/sizemesh:max(xdata(:,2)));
if firstorsecondorder==1
    Fmodel=a(1)*data2X+a(2)*data2Y+a(3);
elseif firstorsecondorder==2
    Fmodel=a(1)*data2X+a(2)*data2Y+a(3)+a(4)*data2X.^2+a(5)*data2Y.^2+a(6)*data2X.*data2Y;
elseif firstorsecondorder==3
    Fmodel=a(1)*data2X+a(2)*data2Y+a(3)+a(4)*data2X.^2+a(5)*data2Y.^2+a(6)*data2X.*data2Y+...
        a(7)*data2X.*data2X.*data2X+a(8)*data2Y.*data2Y.*data2Y+a(9)*data2X.*data2X.*data2Y+...
        a(10)*data2X.*data2Y.*data2Y;
elseif firstorsecondorder==4
    Fmodel=a(1)*data2X+a(2)*data2Y+a(3)+a(4)*data2X.^2+a(5)*data2Y.^2+a(6)*data2X.*data2Y+...now third
        a(7)*data2X.*data2X.*data2X+a(8)*data2Y.*data2Y.*data2Y+a(9)*data2X.*data2X.*data2Y+...
        a(10)*data2X.*data2Y.*data2Y+...now fourth
        a(11)*data2X.*data2X.*data2X.*data2X+a(12)*data2X.*data2X.*data2X.*data2Y+...
        a(13)*data2X.*data2X.*data2Y.*data2Y+a(14)*data2X.*data2Y.*data2Y.*data2Y+...
        a(15)*data2Y.*data2Y.*data2Y.*data2Y;
elseif firstorsecondorder==5
        Fmodel=a(1)*data2X+a(2)*data2Y+a(3)+a(8)*a(4)./...
            ((bsxfun(@plus,data2X*a(5)+data2Y*a(6),a(7))).^2+a(4)^2);
end

%surf(data2X,data2Y,Fmodel)
%surf(pcpfx,pcpfy,pcpfs) debug

surf(data2X,data2Y,Fmodel)
hold on
scatter3(pcpointstress(:,1),pcpointstress(:,2),pcpointstress(:,3),'filled','MarkerFaceColor',[1 0 0])
hold off
xlabel('Coordinates in PC 1 /arb units')
ylabel('Coordinates in PC 2 /arb units')
zlabel('Stress per unit angle, GPa/rad')

title('Simulated Stress/Angle')
legend({'10 points across 2 PC','Model Prediction'})

print('thesis_SS model 2pc','-dpng','-r0')
savefig(['thesis_SS model 2pc'])
%%
saveas(gcf,[samplefolder, 'stressmodelfig'],'png')

%% Calculating stiffness of samples
stresssamples2=table2array(n4dims);
stresssamples2=stresssamples2(:,1:6);
% Using the previous code to re-translate the original coordinates
% (including outliers)
allscores=bsxfun(@plus,stresssamples2,-mu)*(diag(w)*eigenvectors);
% and save the calculated stiffness in that matrix in an extra column

stresssamples2(:,size(stresssamples2,2)+1)=myfun(a,allscores);
stresssamples2(:,size(stresssamples2,2)+1)=stresssamples2(:,size(stresssamples2,2));

disp(['Stresses saved in stresssamples2 under column ' num2str(size(stresssamples2,2))])
%% sensitivity things
meangeom=mean(stresssamples2(:,1:6));%define the mean geometry of all samples
meanofall_scores=bsxfun(@plus,meangeom,-mu)*(diag(w)*eigenvectors); %that, but in PC space

stressmean=myfun(a,meanofall_scores); %find the mean stressratio

sensitivity1um=bsxfun(@plus,(meangeom-eye(size(meangeom,2))),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1um=stressmean-myfun(a,sensitivity1um);
sensitivity1um=sensitivity1um';


sensitivity1pc=bsxfun(@plus,(meangeom-(eye(size(meangeom,2)).*0.01).*meangeom),-mu)*(diag(w)*eigenvectors); 
%construct a matrix with 1 away from everything along the diagonals
%and then subtract the resfreqmean with this.
sensitivity1pc=stressmean-myfun(a,sensitivity1pc);
sensitivity1pc=sensitivity1pc';

save([samplefolder filename(1:5) 'PCstressvars'])

%% Plot the estimated values for the samples on the 3d plot
figure('units','normalized','outerposition',[0 0 1 1])
surf(data2X,data2Y,Fmodel)
alpha 0.8
hold on
scatter3(pcpointstress(:,1),pcpointstress(:,2),pcpointstress(:,3),'filled','MarkerFaceColor',[1 0 0])
scatter3(allscores(:,1),allscores(:,2),stresssamples2(:,8),'filled','MarkerFaceColor',[0 0 0])
hold off
xlabel('Coordinates in PC 1')
legend({'Model surface', 'Test points from 2 PC''s', 'Model-estimated values for samples'})
ylabel('Coordinates in PC 2')
zlabel('Stress per unit angle (GPa / rad)')
title('Stiffness of sample points and predicted stiffness from model')
saveas(gcf,[samplefolder, 'stressmodelfigwithsamples'],'png')

%% Optional if you want to colour by position relative to resonant frequency
%Colour based on location. If it's between 19700 and 19760, red, otherwise
%green or blue, and more intense for closer.
%
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
%% the function 

function F = myfun(a,data)
    pc1 = data(:,1);
    pc2 = data(:,2);
    firstorsecondorder=evalin('base','firstorsecondorder');
    if firstorsecondorder==1
        F=a(1)*pc1+a(2)*pc2+a(3);
    elseif firstorsecondorder==2
       F=a(1)*pc1+a(2)*pc2+a(3)+a(4)*pc1.^2+a(5)*pc2.^2+a(6)*pc1.*pc2;
    elseif firstorsecondorder==3 %lol
        F=a(1)*pc1+a(2)*pc2+a(3)+a(4)*pc1.^2+a(5)*pc2.^2+a(6)*pc1.*pc2 + ...
        a(7)*pc1.*pc1.*pc1+a(8)*pc2.*pc2.*pc2+a(9)*pc1.*pc1.*pc2+ ...
        a(10)*pc1.*pc2.*pc2;
    elseif firstorsecondorder==4 %lol
        F=a(1)*pc1+a(2)*pc2+a(3)+a(4)*pc1.^2+a(5)*pc2.^2+a(6)*pc1.*pc2 + ...
        a(7)*pc1.*pc1.*pc1+a(8)*pc2.*pc2.*pc2+a(9)*pc1.*pc1.*pc2+...
        a(10)*pc1.*pc2.*pc2+ ... that was third order, now fourth
        a(11)*pc1.*pc1.*pc1.*pc1+a(12)*pc1.*pc1.*pc1.*pc2+...
        a(13)*pc1.*pc1.*pc2.*pc2+a(14)*pc1.*pc2.*pc2.*pc2+...
        a(15)*pc2.*pc2.*pc2.*pc2;
    elseif firstorsecondorder==5 %lol
        F=a(1)*pc1+a(2)*pc2+a(3)+a(8)*a(4)./((bsxfun(@plus,pc1*a(5)+pc2*a(6),a(7))).^2+a(4)^2);
    end
end
