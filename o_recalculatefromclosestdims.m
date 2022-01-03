% function o_recalculatefromclosestdims(sample,newthickness)
    clear
    samplefolder=[pwd ];%'\foil7t11\'];

    %Re-calculate the stiffness once you've measured the thickness after
    %fracture
    %Takes in the CLOSEST DIMS, asks which sample you're wanting, and
    %calculates the new S/A
    %Load the raw data table
    load([samplefolder '\foils7t11EP.mat'])
    %load closestdims
    load([samplefolder '\closestdims.mat'])

    mu=0; %some function is called this, so initialise with this
    load([samplefolder '\foils7-11PCstressvars.mat'])

    
    oldscore=(foils7t11EP{:,3:8}-mu)*(diag(w)*eigenvectors);%convert to pc space
    oldSS=f_SSfunction(a,oldscore);%calc SS for sanity
    
    
    newscore=(closestdims(:,1:6)-mu)*(diag(w)*eigenvectors);%convert to pc space
    newSS=f_SSfunction(a,newscore);%calc SS for sanity
    


    load([samplefolder '\foils7-11PCfreqvars.mat'])
    oldresfreq=PolynomialFormula(oldscore(:,1),oldscore(:,2),oldscore(:,3));%calc SS for sanity

    newresfreq=PolynomialFormula(newscore(:,1),newscore(:,2),newscore(:,3));%calc SS for sanity



% end
