function GA21b
    cityLocations = LoadCityLocations;
    [numCities, ~] = size(cityLocations);
    
    populationSize = 100;
    numberOfGenes = numCities;
    tournamentSize = 5;
    selectionParameter = 0.75;
    mutationProbability = 0.02;
    crossoverProbability = 0.;
    elitismInsertions = 1;
    numberOfGenerations = 100000;
    
    animate = true;
    verbose = false;

    population = InitializePopulation(populationSize, numberOfGenes);

    if animate
        tspFigure = InitializeTspPlot(cityLocations, [0 20 0 20]); 
        connection = InitializeConnections(cityLocations);
    end

    bestFitness = -inf;
    for n = 1:numberOfGenerations
        newBest = false;

        fitnessValues = zeros(populationSize, 1);

        for i = 1:populationSize
            chromosome = population(i, :);
            fitnessValues(i, :) = EvaluateIndividual(cityLocations, ...
                                                     chromosome);
            if fitnessValues(i) > bestFitness
                bestFitness = fitnessValues(i);
                bestIndividual = population(i, :);
                newBest = true;
            end
        end

        if newBest && animate
            title(num2str(1/bestFitness));
            PlotPath(connection, cityLocations, bestIndividual);
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

        newPopulation = InsertBestIndividual(newPopulation, ...
                                             bestIndividual, ...
                                             elitismInsertions);

        population = newPopulation;

        if verbose
            clc
            msg = "(%.f/%.f) length: %.4f\n";
            fprintf(msg, n, numberOfGenerations, 1/bestFitness);
        end
    end
end




