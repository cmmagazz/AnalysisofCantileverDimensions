function newSS=f_recalculateSS(sample,newthickness)
    %Re-calculate the stiffness once you've measured the thickness after
    %fracture
    %Takes in the CLOSEST DIMS, asks which sample you're wanting, and
    %calculates the new S/A
    
    mu=0; %some function is called this, so initialise with this
    samplefolder=[pwd '\foil4-3n4Data\'];
    load([samplefolder '\foil4PCstressvars.mat'])

% %if you dont have the names:
%     names=cell(size(closestdims,1),1); %then paste them in
%     save([samplefolder filename(1:5) 'names'],'names')
    
    %if you do; 
    load([pwd '\foil4-3n4Data\' 'foil4names.mat'])

    id=find(strcmp(sample,names));%get the row in question

    oldscore=(closestdims(id,:)-mu)*(diag(w)*eigenvectors);%convert to pc space
    oldSS=f_SSfunction(a,oldscore);%calc SS for sanity
    disp(['Old SS value was: ', num2str(oldSS)])
    
    newmeasdim=closestdims(id,:);%redefine thickness
    newmeasdim(6)=newthickness;

    newscore=bsxfun(@plus,newmeasdim,-mu)*(diag(w)*eigenvectors);%convert to pc space
    
    newSS=f_SSfunction(a,newscore);%calculate new SS
    disp(['New SS value was: ', num2str(newSS)])%disp
end