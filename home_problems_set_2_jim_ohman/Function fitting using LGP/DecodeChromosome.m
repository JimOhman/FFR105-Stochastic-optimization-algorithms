function output = DecodeChromosome(chromosome)
    [numberOfGenes, ~] = size(chromosome.genes);
    for i = 1:numberOfGenes
        gene = chromosome.genes(i, :);
        
        operator = chromosome.operators{gene(1)};
        
        if gene(3) <= chromosome.numberOfVariables
            firstOperand = chromosome.variables(:, gene(3));
        else
            constantIdx = gene(3) - chromosome.numberOfVariables;
            firstOperand = chromosome.constants(constantIdx);
        end
        
        if gene(4) <= chromosome.numberOfVariables
            secondOperand = chromosome.variables(:, gene(4));
        else
            constantIdx = gene(4) - chromosome.numberOfVariables;
            secondOperand = chromosome.constants(constantIdx);
        end
        
        result = operator(firstOperand, secondOperand);
        
        chromosome.variables(:, gene(2)) = result;
    end
    output = chromosome.variables(:, 1);
end




