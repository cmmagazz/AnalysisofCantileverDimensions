%Script to clear failed runs based on dudodb variable
%First delete the .odb file for the runs that failed. This then deletes all
%files with the same name EXCEPT for the inp file (hopefully). 

dudodb(i)
totaldel=0;
for i = 1:numel(dudodb) %run the job names
    cmd_str = ['for %i in (', filepath , jobname{dudodb(i)}, '.*) do if not "%~i" == "',...
        filepath , jobname{dudodb(i)},'.inp" del "%~i"'];
    disp(['Deleting: ', num2str(dudodb(i))])
    system(cmd_str);
    totaldel=totaldel+1;
end
disp(['Deleted: ', num2str(totaldel)])

