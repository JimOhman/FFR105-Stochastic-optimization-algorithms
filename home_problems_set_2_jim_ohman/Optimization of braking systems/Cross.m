function newIndividuals = Cross(individuals)
   
    weightsOne = individuals{1}.weights;
    biasesOne = individuals{1}.biases;
    weightsTwo = individuals{2}.weights;
    biasesTwo = individuals{2}.biases;
    
    chromosomeOne = [];
    chromosomeTwo = [];
    for i = 1:length(weightsOne)
        dummyOne = cat(1, weightsOne{i}, ...
                          biasesOne{i});
        dummyOne = reshape(dummyOne, 1, []);
        chromosomeOne = cat(2, chromosomeOne, dummyOne);

        dummyTwo = cat(1, weightsTwo{i}, ...
                          biasesTwo{i});
        dummyTwo = reshape(dummyTwo, 1, []);
        chromosomeTwo = cat(2, chromosomeTwo, dummyTwo);
    end
    
    crossAt = 1 + fix(rand * (length(chromosomeOne) - 1));

    tempOne = chromosomeOne;
    tempTwo = chromosomeTwo;
    chromosomeOne(1:crossAt) = tempTwo(1:crossAt);
    chromosomeTwo(1:crossAt) = tempOne(1:crossAt);
    
    for i = 1:length(weightsOne)
        [n, N] = size(weightsOne{i});
        biasIdx = (n+1):(n+1):(n*N + N);
        weightsIdx = setdiff(1:(n*N + N), biasIdx);
        
        individuals{1}.biases{i} = chromosomeOne(biasIdx);
        individuals{1}.weights{i} = reshape(chromosomeOne(weightsIdx), n, N);
        
        individuals{2}.biases{i} = chromosomeTwo(biasIdx);
        individuals{2}.weights{i} = reshape(chromosomeTwo(weightsIdx), n, N);
    end
    
    newIndividuals = individuals;
end