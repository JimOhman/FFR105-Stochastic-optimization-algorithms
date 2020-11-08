function population = Mutate(population, mutateProbability)
    
    mutationRanges = [population{1}.numberOfOperators, ...
                      population{1}.numberOfVariables, ...
                      population{1}.numberOfOperands, ...
                      population{1}.numberOfOperands];
                  
    populationSize = length(population);
    for i = 1:populationSize
        individual = population{i};
        genesSize = size(individual.genes);
        
        mutateAt = rand(genesSize) < mutateProbability;
        
        mutations = fix(rand(genesSize) .* mutationRanges + 1);
        
        individual.genes(mutateAt) = mutations(mutateAt);
        
        population{i} = individual;
    end
end