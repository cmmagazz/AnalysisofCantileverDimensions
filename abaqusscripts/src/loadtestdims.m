
function testdims=loadtestdims(filename) %just get the testdims
%FOIL 3 and 4
% delimiter = ','; formatSpec = '%f%f%f%f%f%f%[^\n\r]';
% fileID = fopen(filename,'r');
% dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,...
%     'TextType', 'string',  'ReturnOnError', false);
% fclose(fileID);
% dimensionstotest = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3','VarName4','VarName5','VarName6'});
% clearvars filename delimiter formatSpec fileID dataArray ans;
% testdims=table2array(dimensionstotest); 
% clear dimensionstotest
% FOIL 7 -11
delimiter = ','; formatSpec = '%s%s%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,...
    'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
n4dims = table(dataArray{1:end-1}, 'VariableNames', {'Type','Sample','A','B','C','D','E','t','quality','time','polbatch','imagbatch'});
clearvars delimiter formatSpec fileID dataArray ans;

testdims=table2array(n4dims(:,1:6));

end
