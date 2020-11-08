function selectedIndex = TournamentSelect(fitnessValues, ...
                                          selectionParameter, ...
                                          tournamentSize)
    populationSize = length(fitnessValues);
    individualsTakingPart = randperm(populationSize, tournamentSize);
    
    [~, sortedIndividuals] = sort(fitnessValues(individualsTakingPart), ...
                                  'descend');
    
    for i = 1:tournamentSize
        selectedIndex = individualsTakingPart(sortedIndividuals(i));
        if rand < selectionParameter
            break;
        end
    end
end
