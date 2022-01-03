
function resfreq=runinputRESFREQ(testdims,n,maxparralel,filepath)
% currdate=clock;
% currdate=currdate(1:3);
currdate=[];
outputname=['freqpostcalib7-11_PC3' num2str(currdate)];

for i = 1:n %set up the job names
    jobname{i} = ['F33ir_for', num2str(floor(testdims(i,1))),'_',num2str(floor(testdims(i,2))),'_',...
        num2str(floor(testdims(i,3))),'_',num2str(floor(testdims(i,4))),'_',...
        num2str(floor(testdims(i,5))),'_',num2str(floor(testdims(i,6)))];
end

RUNTHEINPFILES(filepath,jobname,maxparralel,n)

resfreq=zeros(n,size(testdims,2)+1);
dudodb=[];
f = waitbar(0,'Running through files');
for i = 1:n
    waitbar(i/n,f);
    try
        %the data we want for the frequency is in the DAT file once completed. 
        datfile_name=[filepath jobname{i},'.dat']; 
        T = readtable(datfile_name, 'Delimiter',' ','MultipleDelimsAsOne',true );
        id = find(strcmp('EIGENVALUE',T{:,3})); %find the line with EIGENVALUE
        id=id+3; %go down three, and one right
        resfreq(i,7)=str2double(char(T{id,4})); %pick out the value
        resfreq(i,1:6)=testdims(i,1:6); %store with dimensions
    catch
        dudodb=[dudodb,i]; %sometimes the odb is done and the right size but has no data. need to re-run the input file. 
    end
    if isnan(resfreq(i,7))
        dudodb=[dudodb,i]; %
    end
end
close(f)
if size(dudodb)~=0
    disp('Dud .odbs are: ') 
    disp(num2str(dudodb(:)))
end
save(outputname,'resfreq')
disp('Resonant Frequencies saved')

end
