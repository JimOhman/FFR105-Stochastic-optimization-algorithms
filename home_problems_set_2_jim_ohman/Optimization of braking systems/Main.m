function Main
    constants = struct('slopeLength', 1000, ...
                       'timeStep', 0.2, ...
                       'ambientTemp', 283, ...
                       'mass', 20000, ...
                       'g', 9.82, ...
                       'tau', 30, ...
                       'tempConstant', 40, ...
                       'gearConstant', 3000, ...
                       'maxTemp', 750, ...
                       'maxVelocity', 25, ...
                       'minVelocity', 1, ...
                       'maxAngle', 10, ...
                       'initialPosition', 0, ...
                       'initialVelocity', 20, ...
                       'initialBreakTemp', 500, ...
                       'initialGear', 7);
                
    gearWeights = [7, 5, 4, 3, 2.5, 2, 1.6, 1.4, 1.2, 1];
    constants.engineForces = constants.gearConstant * gearWeights;
                
    populationSize = 100;
    tournamentSize = 2;
    selectionParameter = 0.75;
    crossoverProbability = 0.8;
    mutationProbability = 0.025;
    elitismInsertions = 1;
    numberOfGenerations = 1000;
    
    verbose = true;
    
    numberOfNeurons = 10;
    activations = {@(x) tanh(x), ...
                   @(x) 1 ./ (1 + exp(-x))};
    
    population = InitializePopulation(populationSize, ...
                                      numberOfNeurons, ...
                                      activations);
    
    iTrainingDataset = 1;
    iTrainingSlopes = 1:10;
    iValidationDataset = 2;
    iValidationSlopes = 1:5;
    
    trainingFitnessValues = zeros(1, numberOfGenerations);
    validationFitnessValues = zeros(1, numberOfGenerations);
    
    bestTrainingFitness = -inf;
    for n = 1:numberOfGenerations
        trainingFitnesses = zeros(1, populationSize);
        bestValidationFitness = -inf;
        for i = 1:populationSize
            individual = population{i};
            
            trainingFitness = EvaluateIndividual(individual, ...
                                                 constants, ...
                                                 iTrainingSlopes, ...
                                                 iTrainingDataset, ...
                                                 false, ...
                                                 false);
            trainingFitnesses(i) = trainingFitness;
            if trainingFitness > bestTrainingFitness
                bestTrainingFitness = trainingFitness;
                bestTrainingIndividual = population{i};
            end
            
            validationFitness = EvaluateIndividual(individual, ...
                                                   constants, ...
                                                   iValidationSlopes, ...
                                                   iValidationDataset, ...
                                                   false, ...
                                                   false);
            if validationFitness > bestValidationFitness
                bestValidationFitness = validationFitness;
                bestValidationIndividual = individual;
            end
        end
        
        newPopulation = population;
        for i = 1:2:populationSize
            selectedIndexes = zeros(2, 1);
            for j = 1:2
                selectedIndex = TournamentSelect(trainingFitnesses, ...
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
                                             bestTrainingIndividual, ...
                                             elitismInsertions);
        population = newPopulation;
        
        if verbose
            clc
            msg = "(%.f/%.f) training: %.2f, validation: %.2f\n";
            fprintf(msg, n, numberOfGenerations, bestTrainingFitness, ...
                                                 bestValidationFitness);
        end
        
        trainingFitnessValues(n) = bestTrainingFitness;
        validationFitnessValues(n) = bestValidationFitness;
    end
    
    plot(1:numberOfGenerations, trainingFitnessValues, '-', 'LineWidth', 2)
    hold on
    plot(1:numberOfGenerations, validationFitnessValues, '-', 'LineWidth', 2)
    hold off
    xlabel('generation', 'fontsize', 17)
    ylabel('fitness', 'fontsize', 17)
    legend('training', 'validation', 'fontsize', 12)
    
    save('bestIndividual.mat', '-struct', 'bestValidationIndividual')
    save('constants.mat', '-struct', 'constants')
end






