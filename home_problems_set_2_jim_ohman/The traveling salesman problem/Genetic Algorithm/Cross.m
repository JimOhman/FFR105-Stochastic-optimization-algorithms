function newIndividuals = Cross(individuals)
    numberOfGenes = size(individuals, 2);
    swapIdxOne = 1 + fix(rand * (numberOfGenes - 1));
    swapIdxTwo = 1 + fix(rand * (numberOfGenes - 1));
    
    newIndividuals = individuals;
    swapFrom = min(swapIdxOne, swapIdxTwo);
    swapTo = max(swapIdxOne, swapIdxTwo);
    
    substringOne = individuals(1, swapFrom:swapTo);
    substringTwo = individuals(2, swapFrom:swapTo);
    
    restOne = individuals(1, :);
    restOne = restOne(~ismember(restOne, substringTwo));
    
    restTwo = individuals(2, :);
    restTwo = restTwo(~ismember(restTwo, substringOne));
    
    restIdx = numberOfGenes - swapTo;
    newIndividuals(1, swapTo+1:end) = restTwo(1:restIdx);
    newIndividuals(1, 1:swapFrom-1) = restTwo(restIdx+1:end);
    newIndividuals(2, swapTo+1:end) = restOne(1:restIdx);
    newIndividuals(2, 1:swapFrom-1) = restOne(restIdx+1:end);
end