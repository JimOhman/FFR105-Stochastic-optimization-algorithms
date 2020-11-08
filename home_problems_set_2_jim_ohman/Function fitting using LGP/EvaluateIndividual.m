function fitnessValue = EvaluateIndividual(individual, data)
    
    batchSize = length(data.input);
    individual.variables = zeros(batchSize, individual.numberOfVariables);
    individual.variables(:, 1) = data.input;
    
    output = DecodeChromosome(individual);
    
    error = sqrt(mean((output-data.target).^2));
    
    fitnessValue = 1 / error;
end