% z_understandingdata
%Script just to faff about comparing dimensions
% CMM 2020

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
batch=table2array(n4dims(:,9)); %keep this just to show which batch things belong 
%to if needed FORMAT IS 1,2,3 etc. for now with only 2

%visualise
gplotmatrix(x,[],batch,[],'+xo',[],[],'grpbars',xnames) %show the inter-dimensional scatter / relationships
title('Original Data for cantilevers')


%% experimental stiffness temporary post

stiffexp=[4335.951315,
3321.832052,
3799.899764,
3578.667596,
2717.001348,
2839.193021,
4436.926021,
2148.623021,
4308.242826,
4291.667415,
3078.747862,
3402.327376,
2409.5826,
2244.416773,
3207.08205,
2982.649988,
2413.066936,
2744.457522,
3399.294566,
3057.486136,
2837.520559,
2982.70619,
2971.755286,
2543.764949,
3100.554987,
2127.201658,
1874.049297,
1625.458509,
2029.820299,
1917.638695,
1933.250483,
1538.84636,
1860.126474,
1457.470239,
];
