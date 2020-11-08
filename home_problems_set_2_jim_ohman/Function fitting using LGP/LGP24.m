function LGP24
    data = LoadFunctionData;
    data = struct('input', data(:, 1), 'target', data(:, 2));
    
    operators = {@Addition, @Subtraction, @Multiplication, @Division};
    variables = [0, 0, 0];
    constants = [1];
    
    populationSize = 100;
    tournamentSize = 5;
    selectionParameter = 0.75;
    crossoverProbability = 0.2;
    mutationProbability = 0.04;
    elitismInsertions = 1;
    numberOfGenerations = 5000;
    
    verbose = true;
    
    geneRange = [5, 10];
    population = InitializePopulation(populationSize, ...
                                      geneRange, ...
                                      operators, ...
                                      variables, ...
                                      constants);
    
    bestErrors = zeros(1, numberOfGenerations);
    bestError = inf;
    bestFitness = -inf;

    for n = 1:numberOfGenerations
        fitnessValues = zeros(populationSize, 1);
        for i = 1:populationSize
            individual = population{i};
            fitnessValue = EvaluateIndividual(individual, data);
            fitnessValues(i) = fitnessValue;
            
            if fitnessValue > bestFitness
                bestFitness = fitnessValue;
                bestError = (1 / fitnessValue);
                bestIndividual = individual;
            end
        end
        
        newPopulation = population;
        for i = 1:2:populationSize
            selectedIndexes = zeros(2, 1);
            for j = 1:2
                selectedIndex = TournamentSelect(fitnessValues, ...
                                                 selectionParameter, ...
                                                 tournamentSize);
                selectedIndexes(j) = selectedIndex;
            end
            
            newIndividuals = population(selectedIndexes);
            if rand < crossoverProbability
                newIndividuals = Cross(newIndividuals);
            end
            newPopulation([i, i+1]) = newIndividuals;
        end
        
        newPopulation = Mutate(newPopulation, mutationProbability);
        newPopulation = InsertBestIndividual(newPopulation, ...
                                             bestIndividual, ...
                                             elitismInsertions);
        population = newPopulation;
        
        if verbose
            clc
            msg = "(%.f/%.f) length: %.f, error: %.6f\n";
            [numberOfGenes, ~] = size(bestIndividual.genes);
            fprintf(msg, n, numberOfGenerations, numberOfGenes, bestError);
        end
        
        bestErrors(n) = bestError;
    end
    save('bestIndividual.mat', '-struct', 'bestIndividual')
    TestLGPChromosome
end