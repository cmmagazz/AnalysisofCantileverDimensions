
function stiffness=runinputSTIFFNESS(testdims,n,maxparralel,filepath)
% currdate=clock;
% currdate=currdate(1:3);
currdate=[];
outputname=['stiffnesspostcalib_7-11_PC3' num2str(currdate)];

loadN=0.002*1; %set the load that you put it at IT APPLIES THE LOAD AT EVERY POINT
disp(['loadN=' num2str(loadN)]);
for i = 1:n %set up the job names
    jobname{i} = ['stiff33ir_for', num2str(floor(testdims(i,1))),'_',num2str(floor(testdims(i,2))),'_',...
        num2str(floor(testdims(i,3))),'_',num2str(floor(testdims(i,4))),'_',...
        num2str(floor(testdims(i,5))),'_',num2str(floor(testdims(i,6)))];
end

RUNTHEINPFILES(filepath,jobname,maxparralel,n)

% Now run through every odb and create a .txt file containing:
% we will want a table with dims and load and displacement

disp('Compiling all results')

stiffness=zeros(n,size(testdims,2)+3);
for i = 1:n %set up the results file
    stiffness(i,1:6)=[testdims(i,1),testdims(i,2),testdims(i,3),testdims(i,4),...
        testdims(i,5),testdims(i,6)];
end

parfor i=1:n %loop through all input files
    commandStr = ['abaqus python ' 'Z:\CM\GitHub\FatigueCMM\AnalysisofCantileverDimensions\abaqusscripts\stiffscript.py ', filepath,' ', jobname{i}];
    system(commandStr); %this time no need to let it wait
    %details are in the script files themselves. it's relatively
    %selfexplanatory
end

dudodb=[];
stiffnesstmp=zeros(n,3);
for i=1:n
    try
        fid = fopen([filepath,jobname{i},'stiffness.txt'],'rt');
        C = textscan(fid, '%f%f', 'MultipleDelimsAsOne',true, 'Delimiter','[; ', 'HeaderLines',0);
        fclose(fid);
        disp(['Job number: ', num2str(i)])
        C=cell2mat(C);
        stiffrow=[loadN,abs(nanmean(C(:,1))),loadN/abs(nanmean(C(:,1)))];
        %stiffness(i,7)=loadN;
        %stiffness(i,8)=abs(nanmean(C(:,1)));
        if nanstd(C(:,1))/nanmean(C(:,1))>0.005
            disp(['You might have some problems at run: ' num2str(i)])
        end
        %stiffness(i,9)=stiffness(i,7)/stiffness(i,8);
        stiffnesstmp(i,:)=stiffrow;
    catch
        dudodb=[dudodb,i]; %sometimes the odb is done and the right size but has no data. need to re-run the input file. 
    end
end
stiffness(:,7:9)=stiffnesstmp;

if size(dudodb)~=0
    disp('Dud .odbs are: ') 
    disp(num2str(dudodb(:)))
end
save(outputname,'stiffness')
disp('Stiffnesses saved')
end
