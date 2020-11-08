function population = InsertBestIndividual(population, ...
                                           previousBestIndividual, ...
                                           numberOfInsertions)
    for i = 1:numberOfInsertions
        population(i, :) = previousBestIndividual;
    end
end
