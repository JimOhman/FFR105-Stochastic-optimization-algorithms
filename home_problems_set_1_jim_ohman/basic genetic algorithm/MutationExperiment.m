function MutationExperiment
    populationSize = 100;
    numberOfGenes = 50;
    numberOfVariables = 2;
    variableRange = 10.0;
    tournamentSize = 2;
    selectionParameter = 0.75;
    crossoverProbability = 0.8;
    elitismInsertions = 1;
    numberOfGenerations = 100;
    
    mutationProbabilities = [0.00, 0.02, 0.05, 0.10];
    gridLength = length(mutationProbabilities);
    repeat = 100;
    
    figure('Units', 'Normalized', 'Position', [0.25, 0.25, 0.3, 0.6]);
    hold on;
    title(sprintf('%.f runs', repeat), 'fontsize', 15)
    xlabel('Generation', 'fontsize', 15)
    ylabel('Median best fitness', 'fontsize', 15)
    legendLabels = cell(gridLength, 1);
    
    medianFitnessValues = zeros(gridLength, numberOfGenerations);
    for gridIndex = 1:gridLength
        mutationProbability = mutationProbabilities(gridIndex);
        
        bestFitnessValues = zeros(repeat, numberOfGenerations);
        for r = 1:repeat
            population = InitializePopulation(populationSize, numberOfGenes);
            
            for n = 1:numberOfGenerations

                bestIndex = 0;
                bestFitness = -inf;

                populationVariables = zeros(populationSize, 2, 1);
                fitnessValues = zeros(populationSize, 1);
                for i = 1:populationSize
                    chromosome = population(i, :);
                    x = DecodeChromosome(chromosome, ...
                                         numberOfVariables, ...
                                         variableRange);
                    fitnessValues(i) = EvaluateIndividual(x(1), x(2));
                    populationVariables(i, :) = x;

                    if fitnessValues(i) > bestFitness
                        bestFitness = fitnessValues(i);
                        bestIndex = i;
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

                    newIndividuals = population(selectedIndexes, :);
                    if rand < crossoverProbability
                        newIndividuals = Cross(newIndividuals);
                    end

                    newPopulation([i, i+1], :) = newIndividuals;
                end

                newPopulation = Mutate(newPopulation, mutationProbability);

                bestIndividual = population(bestIndex, :);
                newPopulation = InsertBestIndividual(newPopulation, ...
                                                     bestIndividual, ...
                                                     elitismInsertions);
                population = newPopulation;


                bestFitnessValues(r, n) = bestFitness;

            end
            
        end
        
        medianFitnessValues(gridIndex, :) = median(bestFitnessValues, 1);
        
        dataToPlot = medianFitnessValues(gridIndex, :);
        plot(1:numberOfGenerations, dataToPlot, 'linewidth', 2);
        legendLabels{gridIndex} = sprintf('Mutation probability: %.f%%', ...
                                          100*mutationProbability);
    end
    
    legend(legendLabels, 'fontsize', 10)
    hold off;
    
    disp('Median fitness value')
    for i = 1:gridLength
        msg = sprintf('    MP = %.f%%: %.4f', ...
                      100*mutationProbabilities(i), ...
                      medianFitnessValues(i, end));
        disp(msg)
    end
    
end




