%short script to empty the temp folder
myFolder = 'E:\Users\CM_Temp';
%cmd_str = ['for %i in (', myFolder , '\*.*) do del "%~i"'];
%everything but txt files
cmd_str = ['for %i in (', myFolder , '\*.*) do if not "%~i" == "', myFolder , '\*.txt" del "%~i"'];
        
dos([cmd_str]);


