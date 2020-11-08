function x = DecodeChromosome(chromosome, numberOfVariables, variableRange)
    numberOfGenes = size(chromosome, 2);
    
    numberOfGenesInVariables = numberOfGenes / numberOfVariables;

    geneWeights = zeros(numberOfGenesInVariables, 1);
    for i = 1:numberOfGenesInVariables
        geneWeights(i) = 2^(-i);
    end
    
    genesInVariables = reshape(chromosome, ...
                               numberOfVariables, ...
                               numberOfGenesInVariables);

    x = genesInVariables * geneWeights;
    normalization = (1-2^(-numberOfGenesInVariables));
    x = -variableRange + 2*variableRange*x / normalization;
end