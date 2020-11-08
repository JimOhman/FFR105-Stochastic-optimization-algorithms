function population = Mutate(population, mutateProbability)
    populationSize = length(population);
    for i = 1:populationSize
        individual = population{i};
        numberOfLayers = length(individual.weights);
        for j = 1:numberOfLayers
            weights = individual.weights{j};
            mutateAt = rand(size(weights)) < mutateProbability;
            toMutate = weights(mutateAt);
            mutation = (2*rand(size(toMutate)) - 1);
            individual.weights{j}(mutateAt) = toMutate + mutation;
            
            biases = individual.biases{j};
            mutateAt = rand(size(biases)) < mutateProbability;
            toMutate = biases(mutateAt);
            mutation = (2*rand(size(toMutate)) - 1);
            individual.biases{j}(mutateAt) = toMutate + mutation;
        end
        population{i} = individual;
    end
end