%% abaqusgeneralrun
% Generalised script for abaqus input file running and getting either: 1)
% stiffness, 2) resonant frequency, 3) steady state response at some
% amplitudes
%INPUTS:
addpath(genpath('abaqusscripts'))
filenamefortestdims = 'Z:\CM\GitHub\FatigueCMM\AnalysisofCantileverDimensions\dimensionstotest_PC3.csv'; %location of testdims
testdims=loadtestdims(filenamefortestdims);

n=size(testdims,1); %how many to analyse
filepath='E:\Users\CM_Temp\'; %location of inp files
GUI_ON='noGUI';


%What do you want to run: 
%% stiffness:
maxparralel=3;

rn_script = sprintf('abaqus cae %s=Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/newscripts/abaqusMacrostiffnessv2.py',GUI_ON);
dos(rn_script);
stiffness=runinputSTIFFNESS(testdims,n,maxparralel,filepath);
fatiguepcaOUT_stiffv2
z_clearthetemp
%% resonant frequency
maxparralel=5;

rn_script = sprintf('abaqus cae %s=Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/newscripts/abaqusMacrosfreqv2.py',GUI_ON);
dos(rn_script);
resfreq=runinputRESFREQ(testdims,n,maxparralel,filepath);
fatiguepcaOUT_freqv2
z_clearthetemp
%% steady state
maxparralel=4;

rn_script = sprintf('abaqus cae %s=Z:/CM/GitHub/FatigueCMM/AnalysisofCantileverDimensions/newscripts/abaqusMacrosSSv2.py',GUI_ON);
dos(rn_script);
[SSstressregression,erroracrossfreq]=runinputSTEADYSTATE(testdims,n,maxparralel,filepath);
fatiguepcaOUT_SSv3
z_clearthetemp
