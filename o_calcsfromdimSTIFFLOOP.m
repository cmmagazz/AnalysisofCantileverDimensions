% o_calcsfromdimSTIFFLOOP
%running the calcsfromdimSTIFF on a loop with the ful dataset. use
%z_understandingdata to input data into stiffexp.

%load stiffness
samplefolder=[pwd '\foil4-3n4Data\'];
filename = 'foil4-3n4postcalib.csv';
load([samplefolder filename(1:5) 'PCstiffvarstest' num2str(3)]) %HOW MANY PC>?

%load the original dimensions
filename = 'foil4-3n4postcalib.csv';
delimiter = ','; formatSpec = '%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen([pwd '\foil4-3n4Data\' filename],'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,...
    'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
n4dims = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3','VarName4','VarName5','VarName6','VarName7','VarName8','VarName9'});
clearvars delimiter formatSpec fileID dataArray ans;

x=table2array(n4dims(:,1:8));

xnames = {'A','B','C','D','E','t','q','time'};

x=x(:,1:6);%keep only A,B,C,D,E,t
xnames=xnames(1:6);
%to if needed FORMAT IS 1,2,3 etc. for now with only 2

%NEW METHOD WITH TABLE
x=foils7t11EP{:,3:8};
stiffexp=foils7t11EP.expstiffness;


%FOR ERRORS:
%stiffexp=stiffexp.*1/1.08;

closestdims=ones(size(x));
for i=1:size(x,1)
    if stiffexp(i)>0
        closestdims(i,:)=o_calcsfromdimSTIFF(x(i,:),stiffexp(i));
    else
        closestdims(i,:)=NaN;
    end
end

templot=[x; closestdims];
templot2=ones(size(templot,1),1);
templot2(end+1-size(closestdims,1):end)=2;
gplotmatrix(templot,[],templot2,[],'+xo',[],[],'grpbars',[]) %show the inter-dimensional scatter / relationships
title(['Measured dims vs pred dims'])

save('closestdims','closestdims')

%% attempts to understand this 
%gplotmatrix by hand....

%a vs stuff
for i=2:6
    subplot(6,6,i)
    scatter(x(:,i),x(:,1),'bx')
    hold on
    scatter(closestdims(:,i),closestdims(:,1),'rx')
    quiver(x(:,i),x(:,1),closestdims(:,i)-x(:,i),closestdims(:,1)-x(:,1),0,'ShowArrowHead','off')
   ylabel('A')
   xlabel(xnames(i))
end


%b vs stuff
for i=3:6
    subplot(6,6,i+6)
    scatter(x(:,i),x(:,2),'bx')
    hold on
    scatter(closestdims(:,i),closestdims(:,2),'rx')
    quiver(x(:,i),x(:,2),closestdims(:,i)-x(:,i),closestdims(:,2)-x(:,2),0,'ShowArrowHead','off')
   ylabel('B')
   xlabel(xnames(i))
end

%c vs stuff
for i=4:6
    subplot(6,6,i+12)
    scatter(x(:,i),x(:,3),'bx')
    hold on
    scatter(closestdims(:,i),closestdims(:,3),'rx')
    quiver(x(:,i),x(:,3),closestdims(:,i)-x(:,i),closestdims(:,3)-x(:,3),0,'ShowArrowHead','off')
   ylabel('C')
   xlabel(xnames(i))
end
%d vs stuff
for i=5:6
    subplot(6,6,i+18)
    scatter(x(:,i),x(:,4),'bx')
    hold on
    scatter(closestdims(:,i),closestdims(:,4),'rx')
    quiver(x(:,i),x(:,4),closestdims(:,i)-x(:,i),closestdims(:,4)-x(:,4),0,'ShowArrowHead','off')
    ylabel('D')
    xlabel(xnames(i))
end

subplot(6,6,30)
scatter(x(:,6),x(:,5),'bx')
hold on
scatter(closestdims(:,6),closestdims(:,5),'rx')
quiver(x(:,6),x(:,5),closestdims(:,6)-x(:,6),closestdims(:,5)-x(:,5),0,'ShowArrowHead','off')
ylabel('E')
xlabel('t')

sgtitle('meas dims vs pred dims with connector')
legend({'Measured dimensions', 'Predicted dimensions'})

%print('meas dims vs pred dims with connector', '-dpng','-r1500')

%%
%a vs stuff
for i=1:5
    subplot(5,5,i)
    scatter(x(:,i+1),x(:,1),'bx')
    hold on
    scatter(closestdims(:,i+1),closestdims(:,1),'rx')
    quiver(x(:,i+1),x(:,1),closestdims(:,i+1)-x(:,i+1),closestdims(:,1)-x(:,1),0,'ShowArrowHead','off')
   ylabel('A')
   xlabel(xnames(i+1))
end


%b vs stuff
for i=2:5
    subplot(5,5,i+5)
    scatter(x(:,i+1),x(:,2),'bx')
    hold on
    scatter(closestdims(:,i+1),closestdims(:,2),'rx')
    quiver(x(:,i+1),x(:,2),closestdims(:,i+1)-x(:,i+1),closestdims(:,2)-x(:,2),0,'ShowArrowHead','off')
   ylabel('B')
   xlabel(xnames(i+1))
end

%c vs stuff
for i=3:5
    subplot(5,5,i+10)
    scatter(x(:,i+1),x(:,3),'bx')
    hold on
    scatter(closestdims(:,i+1),closestdims(:,3),'rx')
    quiver(x(:,i+1),x(:,3),closestdims(:,i+1)-x(:,i+1),closestdims(:,3)-x(:,3),0,'ShowArrowHead','off')
   ylabel('C')
   xlabel(xnames(i+1))
end
%d vs stuff
for i=4:5
    subplot(5,5,i+15)
    scatter(x(:,i+1),x(:,4),'bx')
    hold on
    scatter(closestdims(:,i+1),closestdims(:,4),'rx')
    quiver(x(:,i+1),x(:,4),closestdims(:,i+1)-x(:,i+1),closestdims(:,4)-x(:,4),0,'ShowArrowHead','off')
    ylabel('D')
    xlabel(xnames(i+1))
end

subplot(5,5,25)
scatter(x(:,6),x(:,5),'bx')
hold on
scatter(closestdims(:,6),closestdims(:,5),'rx')
quiver(x(:,6),x(:,5),closestdims(:,6)-x(:,6),closestdims(:,5)-x(:,5),0,'ShowArrowHead','off')
ylabel('E')
xlabel('t')

sgtitle('Scatter matrix of measured and predicted Dimensions')
legend({'Measured dimensions', 'Predicted dimensions'})

%print('meas dims vs pred dims with connector', '-dpng','-r1500')
% savefig(['meas dims vs pred dims with connector'])