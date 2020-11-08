function population = Mutate(population, mutateProbability)
    [populationSize, numberOfGenes] = size(population);
    swapAt = rand(size(population)) < mutateProbability;
    numSwaps = sum(swapAt, 2);
    geneIndices = 1:numberOfGenes;
    for i = 1:populationSize
        indices = geneIndices(swapAt(i, :));
        swapIndices = randperm(numberOfGenes, numSwaps(i));
        for n = 1:numSwaps(i)
            swapIdx = [indices(n), swapIndices(n)];
            population(i, swapIdx) = population(i, flip(swapIdx));
        end
    end
end