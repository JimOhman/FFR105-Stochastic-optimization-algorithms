function population = InitializePopulation(populationSize, ...
                                           geneRange, ...
                                           operators, ...
                                           variables, ...
                                           constants)                              
    numberOfOperators = length(operators);
    numberOfVariables = length(variables);
    numberOfOperands = numberOfVariables + length(constants);
    
    population = cell(populationSize, 1);
    for i = 1:populationSize
        
        numberOfGenes = randi(geneRange);
        individual = struct('genes', zeros(numberOfGenes, 4));
        for j = 1:numberOfGenes
            operator = randi(numberOfOperators);
            register = randi(numberOfVariables);
            firstOperand = randi(numberOfOperands);
            secondOperand = randi(numberOfOperands);
            gene = [operator, register, firstOperand, secondOperand];
            individual.genes(j, :) = gene;
        end
        
        individual.numberOfOperators = numberOfOperators;
        individual.numberOfVariables = numberOfVariables;
        individual.numberOfOperands = numberOfOperands;
       
        individual.operators = operators;
        individual.constants = constants;

        population{i} = individual;
    end
end