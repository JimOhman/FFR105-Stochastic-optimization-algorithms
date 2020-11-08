function FunctionOptimization
    populationSize = 100;
    numberOfGenes = 50;
    numberOfVariables = 2;
    variableRange = 10.0;
    tournamentSize = 2;
    selectionParameter = 0.75;
    crossoverProbability = 0.8;
    mutationProbability = 0.025;
    elitismInsertions = 3;
    numberOfGenerations = 100;
    
    plot = false;
    animate = false;
    
    if plot
        figure('Units', 'Normalized', 'Position', [0.25, 0.25, 0.3, 0.6]);
        subplot(2, 1, 1)
        [X1, X2] = meshgrid(-10:.3:10, -10:.3:10);
        G = EvaluateIndividual(X1, X2).^(-1);
        surf(X1, X2, G);
        xlabel('$x_1$', 'fontsize', 17, 'interpreter', 'latex')
        ylabel('$x_2$', 'fontsize', 17, 'interpreter', 'latex')
        zlabel('$g(x_1, x_2)$', 'fontsize', 17, 'interpreter', 'latex')
        xlim([-variableRange, variableRange])
        ylim([-variableRange, variableRange])

        hold on;
        populationHandle = scatter3(0, 0, 0, 'o', ...
                                             'MarkerFaceColor', 'white', ...
                                             'SizeData', 100);
        hold off;

        subplot(2, 1, 2)
        hold on;
        fitnessHandle = animatedline('Marker', 'o', ...
                                     'MarkerFaceColor', 'red');
        xlabel('Generation', 'fontsize', 15)
        ylabel('Best fitness', 'fontsize', 15)
        hold off;
    end
    
    population = InitializePopulation(populationSize, numberOfGenes);

    for n = 1:numberOfGenerations

        bestIndex = 0;
        bestFitness = -inf;
        bestVariables = zeros(numberOfVariables, 1);

        populationVariables = zeros(populationSize, numberOfVariables, 1);
        fitnessValues = zeros(populationSize, 1);
        for i = 1:populationSize
            chromosome = population(i, :);
            x = DecodeChromosome(chromosome, ...
                                 numberOfVariables, ...
                                 variableRange);
            fitnessValues(i) = EvaluateIndividual(x(1), x(2));
            populationVariables(i, :, :) = x;

            if fitnessValues(i) > bestFitness
                bestFitness = fitnessValues(i);
                bestIndex = i;
                bestVariables = x;
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

        if plot
            addpoints(fitnessHandle, n, bestFitness);

            x1 = populationVariables(:, 1);
            x2 = populationVariables(:, 2);
            g = fitnessValues.^(-1);
            set(populationHandle, 'XData', x1, 'YData', x2, 'ZData', g);
            if animate
                drawnow;
                pause(0.1);
            end
        end
    end
        
    msg = 'Smallest value (%.2f) found at: (x1 = %.2f, x2 = %.2f)';
    disp(sprintf(msg, 1 / bestFitness, bestVariables))

end















