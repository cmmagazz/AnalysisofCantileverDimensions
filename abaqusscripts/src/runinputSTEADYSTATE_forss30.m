
function [SSstressregression,erroracrossfreq]=runinputSTEADYSTATE_forss30(n,maxparralel,filepath)
outputname=['ss30_steadystatepostcalib_PC3'];

amplitudes=[15,20];% how many amplitudes are tested and which ones
frequencies=2;%how many frequencies are tested? no need for which
testdims=55:3:85;

for i = 1:n %set up the job names
    for j=1:size(amplitudes,2) 
        pos=2*i-2+j;%this time, add in the contribution from there being multiple amplitudes at a given dim
        jobname{pos} = ['SS30ir_for',num2str(floor(testdims(i))),'_',num2str(amplitudes(j))];
    end
end
m=n*size(amplitudes,2);
RUNTHEINPFILES(filepath,jobname,maxparralel,m)

%% read odb
%this will run through every odb and create a .txt file containing:
% one row of 0*12
% one row with freq(0), stress(0), 5(x,z) coordinates
% one row with freq(1), stress(1), 5(x,z) coordinates
% one row with freq(2), stress(2), 5(x,z) coordinates
disp('Compiling all results')
maxcpuallowed=60;
maxstress=zeros(n*size(amplitudes,2)*frequencies,size(testdims',2)+1+12);
for i = 1:n %set up the results file
    for j=1:size(amplitudes,2) 
        for k=1:frequencies
            pos=4*i-4+2*j-2+k;
            maxstress(pos,1:3)=[testdims(i),amplitudes(j),0];
        end
    end
end

for i=1:n*size(amplitudes,2) %loop through all input files
    disp(['Reading from file ' num2str(i)])
    commandStr = ['abaqus python ' 'Z:\CM\GitHub\FatigueCMM\AnalysisofCantileverDimensions\abaqusscripts\SteadyStatescript.py ', filepath,' ', jobname{i} ,'&& exit &'];
    system(commandStr); 
    pause(5)
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
for i=1:n*size(amplitudes,2) %loop through all tex files that were created files
    fid = fopen([filepath,jobname{i},'maxstress.txt'],'rt');
    try
        C = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f%f', 'MultipleDelimsAsOne',true, 'Delimiter','[; ', 'HeaderLines',1);
        fclose(fid);
        C=cell2mat(C);
        try
            maxstress(2*i-1:2*i,3:end)=C(2:end,:);
        catch
            try
                maxstress(2*i-1,3:end)=C(2:end,:);
                disp(['Simulation ran only 1 frequency for job ' num2str(i)])
            catch
                disp(['Unable to read job ' num2str(i)])
            end
        end
    catch
        disp(['txt file  doesn''t exist for ' num2str(i)])
    end
end
%calculate the gradients in the sample
Xcoords=maxstress(:,5:2:end);%coordinates of the points are at the back
Zcoords=maxstress(:,6:2:end);
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
SSstress=[maxstress(:,1:4) angle];

%% now calculate the stress/angle

%Step 1 is average across frequencies:
SSstressavgfreq=zeros(size(maxstress,1)/2,size(SSstress,2));%numsimulations but only 1 freq x dims, amps, meanfreq, stress, angls
SSstress=abs(SSstress);
for i =1:size(SSstress,1)/2
    SSstressavgfreq(i,1:2)=SSstress(2*i-1,1:2); %get the dims
    SSstressavgfreq(i,3:end)=mean(SSstress(2*i-1:2*i,3:end)); %average across frequency, stress, and angle
    stdevstressacrossfreq(i,:)=std(SSstress(2*i-1:2*i,3:end)); %USEFUL FOR DEBUG
end
erroracrossfreq=100*stdevstressacrossfreq(:,2:3)./SSstressavgfreq(:,end-1:end); %this has the error in stress and angle across the frequencies
erroracrossfreq(:,3:4)=SSstressavgfreq(:,end-1:end); %add the stress and angle values into here

SSstressregression=zeros(size(SSstressavgfreq,1)/2,7); %sims but only 1 amp x dims,  meanfreq, 
todel=[];
for i=1:size(SSstressavgfreq,1)/2
    clear tempdata
    tempdata(:,2)=SSstressavgfreq(2*i-1:2*i,4);
    tempdata(:,1)=SSstressavgfreq(2*i-1:2*i,5);
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
    SSstressregression(i,1:end-1)=SSstressavgfreq(2*i-1,1); %across amplitudes
    SSstressregression(i,end)=m(1)/1e9;%work in GPa
end
clear tempdata
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


save(outputname,'SSstressregression','erroracrossfreq')
disp('Maximum Stresses saved')

end

