function population = InitializePopulation(populationSize, numberOfGenes)
    population = randi([0, 1], populationSize, numberOfGenes);
end
