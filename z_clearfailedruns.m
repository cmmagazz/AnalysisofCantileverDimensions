%Script to clear failed runs
%First delete the .odb file for the runs that failed. This then deletes all
%files with the same name EXCEPT for the inp file (hopefully). 


totaldel=0;
for i = 1:n %run the job names
    if isfile([filepath jobname{i} '.odb']) %first check if it's there
        disp(['Job number ' num2str(i) ' is ok'])
    else
        cmd_str = ['for %i in (', filepath , jobname{i}, '.*) do if not "%~i" == "',...
            filepath , jobname{i},'.inp" del "%~i"'];
        disp(['Deleting: ', num2str(i)])
        system([cmd_str]);
        totaldel=totaldel+1;
    end
end
disp(['Deleted: ', num2str(totaldel)])

