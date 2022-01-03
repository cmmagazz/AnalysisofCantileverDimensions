%% z_createfigures
% Function to take in the foil data like in samples_foils.xlsx and make
% figures
%
% CMM 2021

%CURATING SOME NAMES FOR TESTING
% 
% for i=1:size(foils7t11EP,1)
%     foils7t11EP.Sample(i)=join(['B', foils7t11EP.Sample(i)],'');
% end
load('Z:\CM\GitHub\FatigueCMM\AnalysisofCantileverDimensions\foil7t11\foils7t11testing.mat')
foils7t11EP=foils7t11testing;
%% Variable names
names={'Type','Sample','A','B','C','D','E','t','quality','time','polbatch','imagbatch',...
    'measdimresfreq','measdimSS','resfreq3PC','SS3PC','stiffness3PC'};
names=foils7t11testing.Properties.VariableNames;

%% Plot histograms of things

whatvariable=names{18};
whatvariable='ResonantFrequency_PG';
% %All - some variable
% hist(foils7t11EP.(whatvariable))

%Material based - some variable
toplot=foils7t11EP.(whatvariable);
toplottemp=toplot(strcmp(foils7t11EP.type,'Alpha'));
h=histogram(toplottemp);
% h.FaceColor = [0 0.5 0.5];
% h.EdgeColor = 'w';
h.BinWidth=0.5;
h.FaceAlpha=0.5;
toplottemp=toplot(strcmp(foils7t11EP.type,'Weld'));
hold on
h=histogram(toplottemp);
% h.FaceColor = [0.5 0.5 0];
% h.EdgeColor = 'w';
h.BinWidth=0.5;
h.FaceAlpha=0.5;
toplottemp=toplot(strcmp(foils7t11EP.type,'Bimodal'));
h=histogram(toplottemp);
% h.FaceColor = [0.5 0 0.5];
% h.EdgeColor = 'w';
h.BinWidth=0.5;
h.FaceAlpha=0.5;
legend({'Alpha','Weld','Bimodal'})

%% Scatter plots

scatter(foils7t11EP.measdimresfreq,foils7t11EP.resfreq3PC)


scatter(foils7t11EP.measdimresfreq,100*(foils7t11EP.resfreq3PC-foils7t11EP.measdimresfreq)./foils7t11EP.measdimresfreq,'k.')
scatter(foils7t11EP.measdimSS,100*(foils7t11EP.SS3PC-foils7t11EP.measdimSS)./foils7t11EP.measdimSS,'k.')


scatter(foils7t11EP.stiffness3PC,foils7t11EP.expstiffness,'r.')

errorbar(foils7t11EP.stiffness3PC,foils7t11EP.expstiffness,foils7t11EP.expstiffness.*0.01,'r.')

scatter(foils7t11EP.nanoindentpos,foils7t11EP.expstiffness,'r.')
%%
figure()
scatter(foils7t11EP.aveT_PG,foils7t11EP.ResonantFrequency_PG,'r.')
xlabel('PG Thickness /\mum')
ylabel('Resfreq PG')
%% Material discrimination



%Material based - some variable
toplot=foils7t11EP.aveT-foils7t11EP.aveT_PG;


toplottemp=toplot(strcmp(foils7t11EP.type,'Alpha'));
plot(toplottemp,'x');
disp(['Alpha ', num2str(nanmean(toplottemp))])

toplottemp=toplot(strcmp(foils7t11EP.type,'Weld'));
hold on
plot(toplottemp,'x');
disp(['Weld ',num2str(mean(toplottemp))])

toplottemp=toplot(strcmp(foils7t11EP.type,'Bimodal'));
plot(toplottemp,'x');
disp(['Bimodal ',num2str(nanmean(toplottemp))])

legend({'Alpha','Weld','Bimodal'})
%% Count stuff
nnz(strcmp(foils7t11EP.type,'Weld') & foils7t11EP.ResonantFrequency_PG<30000)

%% Save
save('foils7t11EP','foils7t11EP')