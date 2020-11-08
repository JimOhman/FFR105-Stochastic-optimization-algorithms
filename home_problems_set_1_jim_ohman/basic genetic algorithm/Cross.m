function newIndividuals = Cross(individuals)
    numberOfGenes = size(individuals, 2);
    crossAt = 1 + fix(rand * (numberOfGenes - 1));
    
    newIndividuals = individuals;
    newIndividuals(1, 1:crossAt) = individuals(2, 1:crossAt);
    newIndividuals(2, 1:crossAt) = individuals(1, 1:crossAt);
end