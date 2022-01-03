
function [SSstressregression]=runinputSTEADYSTATE_fromstiff(testdims,n,maxparralel,filepath)
% currdate=clock;
% currdate=currdate(1:3);
currdate=[];
outputname=['steadystatepostcalib7-11_PC3 from stiff' num2str(currdate)];

loadN=0.002*1; %set the load that you put it at IT APPLIES THE LOAD AT EVERY POINT
disp(['loadN=' num2str(loadN)]);
for i = 1:n %set up the job names
    jobname{i} = ['stiff33ir_for', num2str(floor(testdims(i,1))),'_',num2str(floor(testdims(i,2))),'_',...
        num2str(floor(testdims(i,3))),'_',num2str(floor(testdims(i,4))),'_',...
        num2str(floor(testdims(i,5))),'_',num2str(floor(testdims(i,6)))];
end
% THIS REQUIRES HAVING RAN THE INPUT FILES ALREADY
% RUNTHEINPFILES(filepath,jobname,maxparralel,m)

%% read odb
%this will run through every odb and create a .txt file containing:
% one row of 0*12
% one row with freq(0), stress(0), 5(x,z) coordinates
% one row with freq(1), stress(1), 5(x,z) coordinates
% one row with freq(2), stress(2), 5(x,z) coordinates
disp('Compiling all results')
maxcpuallowed=60;
maxstress=zeros(n,size(testdims,2)+12);
for i = 1:n %set up the results file
    maxstress(i,1:7)=[testdims(i,1),testdims(i,2),testdims(i,3),testdims(i,4),...
        testdims(i,5),testdims(i,6),0];
end

for i=1:n %loop through all input files
    disp(['Reading from file ' num2str(i)])
    commandStr = ['abaqus python ' 'Z:\CM\GitHub\FatigueCMM\AnalysisofCantileverDimensions\abaqusscripts\SteadyStatescriptfromstiff.py ', filepath,' ', jobname{i} ,'&& exit &'];
    system(commandStr); 
    pause(2)
    %details are in the script files themselves. it's relatively
    %selfexplanatory
    cpuIdleProcess = 'Idle' ;
    NumOfCPU = double(System.Environment.ProcessorCount);
    ProcPerfCounter.cpuIdle=System.Diagnostics.PerformanceCounter('Process', '% Processor Time', cpuIdleProcess );
    cputotal = 100 - ProcPerfCounter.cpuIdle.NextValue / NumOfCPU ;
    while cputotal>maxcpuallowed
        pause(1)
        cputotal = 100 - ProcPerfCounter.cpuIdle.NextValue / NumOfCPU ;
    end
end

txtfiles = dir([filepath '*.odb']);
numtxtfiles = numel(txtfiles);
while numtxtfiles<n*size(amplitudes,2)  %keep on hold until the last one is done
    pause(5) 
    disp('Waiting')
    txtfiles = dir([filepath '*.txt']);
    numtxtfiles = numel(txtfiles);
end 
pause(120) 
%% read text files
%this next bit is pretty quick: read through all the text files
for i=1:n %loop through all tex files that were created files
    fid = fopen([filepath,jobname{i},'maxstress.txt'],'rt');
    try
        C = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f%f', 'MultipleDelimsAsOne',true, 'Delimiter','[; ', 'HeaderLines',1);
        fclose(fid);
        C=cell2mat(C);
        try
            maxstress(i,8:end)=C(1,2:end);
        catch
            disp(['Unable to read job ' num2str(i)])
        end
    catch
        disp(['txt file  doesn''t exist for ' num2str(i)])
    end
end
%calculate the gradients in the sample
Xcoords=maxstress(:,9:2:end);
Zcoords=maxstress(:,10:2:end);
%figure();
for i=1:size(Xcoords,1)
    [m,S]=polyfit(Xcoords(i,:),Zcoords(i,:),1);
    %hold on
    %scatter(Xcoords(i,:),Zcoords(i,:));
    rsq= 1 - (S.normr/norm(Zcoords(i,:) - mean(Zcoords(i,:))))^2;
    if rsq<0.9
        disp(['You will have problems in i = ', num2str(i)])
    end
    angle(i)=atan(m(1));
end
angle=abs(angle);
angle=angle';

%save a new variable with the angle instead of all those coords
%maxstress2=[maxstress(:,1:9) angle'];
SSstress=[maxstress(:,1:8) angle];

%% now calculate the stress/angle
%{
%Step 1 is average across frequencies:
SSstressavgfreq=zeros(size(maxstress,1),10);
SSstress=abs(SSstress);
for i =1:size(SSstress,1)
    SSstressavgfreq(i,1:7)=SSstress(i,1:7); %get the dims
    SSstressavgfreq(i,8:10)=mean(SSstress(i,8:10)); %average across frequency, stress, and angle
    stdevstressacrossfreq(i,:)=std(SSstress(i,8:10)); %USEFUL FOR DEBUG
end
erroracrossfreq=100*stdevstressacrossfreq(:,2:3)./SSstressavgfreq(:,9:10); %this has the error in stress and angle across the frequencies
erroracrossfreq(:,3:4)=SSstressavgfreq(:,9:10); %add the stress and angle values into here

SSstressregression=zeros(size(SSstressavgfreq,1)/2,7);
todel=[];
for i=1:size(SSstressavgfreq,1)/2
    clear tempdata
    tempdata(:,2)=SSstressavgfreq(2*i-1:2*i,9);
    tempdata(:,1)=SSstressavgfreq(2*i-1:2*i,10);
    tempdata(3,:)=[0,0];
    %scatter(tempdata(:,1),tempdata(:,2))
    [m,S]=polyfit(tempdata(:,1),tempdata(:,2),1);
    rsq= 1 - (S.normr/norm(tempdata(:,2) - mean(tempdata(:,2))))^2;
    if abs(m(2)/m(1)) > 0.03|| rsq<0.9 %check if either y intercept is large or fit is poor
        disp(['You will have problems in i = ', num2str(i)])
        todel(size(todel,2)+1)=i;
        if tempdata(2,2)<1e10 %if the first point is below 1e9, can use that
            [m,S]=polyfit(tempdata(:,1),tempdata(:,2),1);
            rsq= 1 - (S.normr/norm(tempdata(:,2) - mean(tempdata(:,2))))^2;
            todel(size(todel,2))=[];
            disp('Using one point instead')
        end
    end
    SSstressregression(i,1:6)=SSstressavgfreq(2*i-1,1:6); %across amplitudes
    SSstressregression(i,7)=m(1)/1e9;%work in GPa
end
clear tempdata
%}
%% For stiffness data it's easy: only one point

SSstressregression=[SSstress,zeros(size(SSstress,1),1)];
SSstressregression(:,10)=(SSstress(:,8)./SSstress(:,9))/1e9;


%DEBUG: plot all of them
%{ 
figure;
clear tempdata
tempdata(:,2)=SSstressavgfreq(2*1-1:2*1,9);
tempdata(:,1)=SSstressavgfreq(2*1-1:2*1,10);
tempdata(3,:)=[0,0];
plot(tempdata(:,1),tempdata(:,2))
for i=2:size(SSstressavgfreq,1)/2
    hold on
    clear tempdata
    tempdata(:,2)=SSstressavgfreq(2*i-1:2*i,9);
    tempdata(:,1)=SSstressavgfreq(2*i-1:2*i,10);
    tempdata(3,:)=[0,0];
    plot(tempdata(:,1),tempdata(:,2))
end
%}


save(outputname,'SSstressregression')
disp('Maximum Stresses saved')

end

