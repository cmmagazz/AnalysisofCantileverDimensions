
function RUNTHEINPFILES(filepath,jobname,maxparralel,n) % all the input files are run the same way
% first check if it's run any already
startpos=1;
odbalreadydone=exist([filepath jobname{startpos} '.odb'], 'file');
while odbalreadydone~=0 && startpos<=n-1
    startpos=startpos+1;
    odbalreadydone=exist([filepath jobname{startpos} '.odb'], 'file');
end
if startpos==n
    warning('No new inp to simulate')
    return
end
disp(['Starting from number: ',num2str(startpos)])

i=startpos;
while i<=n %run the job names
    alreadydoneq=isfile([filepath jobname{i} '.odb']);
    while alreadydoneq %first check if it's there
        disp(['Job number ' num2str(i) ' already done'])
        i=i+1;
        if i>numel(jobname) %catch the error where i breaks things
            break
        end
        alreadydoneq=isfile([filepath jobname{i} '.odb']);
    end
    if i>numel(jobname) %catch the error where i breaks things
        break
    end
    cmd_str = ['abaqus job=', jobname{i}, ' input=', filepath,jobname{i}, '.inp interactive &&' ];
    disp(['Job number: ', num2str(i)])
    system([filepath(1:2) ' & cd ', filepath, ' & ' cmd_str]); %move to file location and run it all there
    sw=true; 
    tic; 
    %Waiting code:
    pause(5)
    while sw 
        % Pause Matlab execution in order for the lck file to be created 
        pause(5); 
        % While the lck files exists, pause Matlab execution. If it is 
        % deleted, exit the while loop and proceed. 
        sw=false;
        lckfiles = dir([filepath '*.lck']);
        numlckfiles = numel(lckfiles);
        while numlckfiles>=maxparralel 
            pause(1) 
            lckfiles = dir([filepath '*.lck']);
            numlckfiles = numel(lckfiles);
            % the lck file has been created and Matlab halts in this loop. 
            % Set sw to false to break the outer while loop and continue 
            % the code execution. 
            sw=true; 
        end 
        % In case that the lck file cannot be detected, then terminate 
        % infinite execution of the outer while loop after a certain 
        % execution time limit (5 sec) 
        if sw && (toc>40) 
            sw=false; 
        end 
    end 
    i=i+1;
end
lckfiles = dir([filepath '*.lck']);
numlckfiles = numel(lckfiles);
while numlckfiles>0  %keep on hold until the last one is done
    pause(0.1) 
    lckfiles = dir([filepath '*.lck']);
    numlckfiles = numel(lckfiles);
end 
disp('Finished the simulations')
end
