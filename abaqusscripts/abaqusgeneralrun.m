%% abaqusgeneralrun
% Generalised script for abaqus input file running and getting either: 1)
% stiffness, 2) resonant frequency, 3) steady state response at some
% amplitudes
%INPUTS:
clear all
addpath(genpath('abaqusscripts'))
%filenamefortestdims = 'Z:\CM\GitHub\FatigueCMM\AnalysisofCantileverDimensions\foil7t11\foils7-11dimsonly.csv'; %location of testdims
filenamefortestdims = 'Z:\CM\GitHub\FatigueCMM\AnalysisofCantileverDimensions\foil7t11\dimensionstotest_PC3.csv'; %location of testdims
testdims=loadtestdims(filenamefortestdims);
testdims=double(testdims);

n=size(testdims,1); %how many to analyse
filepath='E:\Users\CM_Temp\'; %location of inp files
GUI_q='noGUI';


%What do you want to run: 
%% resonant frequency
maxparralel=5;

rn_script = sprintf('abaqus cae %s=Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/newscripts/abaqusMacrosfreqv2.py',GUI_q);
dos(rn_script);

resfreq=runinputRESFREQ(testdims,n,maxparralel,filepath);
fatiguepcaOUT_freqv2
%z_clearthetemp

%% stiffness:
maxparralel=5;

rn_script = sprintf('abaqus cae %s=Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/newscripts/abaqusMacrostiffnessv2.py',GUI_q);
dos(rn_script);
stiffness=runinputSTIFFNESS(testdims,n,maxparralel,filepath);
fatiguepcaOUT_stiffv2
%z_clearthetemp

%% steady state
maxparralel=3;
% 
rn_script = sprintf('abaqus cae %s=Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/newscripts/abaqusMacrosSSv2.py',GUI_q);
dos(rn_script);
[SSstressregression,erroracrossfreq]=runinputSTEADYSTATE(testdims,n,maxparralel,filepath);

% [SSstressregression]=runinputSTEADYSTATE_fromstiff(testdims,n,maxparralel,filepath);


fatiguepcaOUT_SSv3
% z_clearthetemp

% %% steady state for the simpler version with only thickness
% maxparralel=1;
% 
% rn_script = sprintf('abaqus cae %s=Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/newscripts/abaqusMacrosSSv2_SS30ir.py',GUI_q);
% dos(rn_script);
% [SSstressregression,erroracrossfreq]=runinputSTEADYSTATE_forss30(n,maxparralel,filepath);
