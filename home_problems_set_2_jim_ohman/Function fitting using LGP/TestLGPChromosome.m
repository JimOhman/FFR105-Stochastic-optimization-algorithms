function TestLGPChromosome
    data = LoadFunctionData;
    data = struct('input', data(:, 1), 'target', data(:, 2));
    batchSize = length(data.input);
    
    %% I'm loading my chromosome as a struct, which includes the constants,
    %% and numberOfVariables, etc. But the file BestChromosome.m loads only
    %% the genes of the best chromosome, which is included in case you have
    %% your own tests. They are the same as chromosome.genes used below.
    
    chromosome = load('bestIndividual.mat');
    
    chromosome.variables = zeros(batchSize, chromosome.numberOfVariables);
    chromosome.variables(:, 1) = data.input;
    
    output = DecodeChromosome(chromosome);
    error = sqrt(mean((output-data.target).^2));
    
    syms x
    chromosome.variables = sym(zeros(1, chromosome.numberOfVariables));
    chromosome.variables(:, 1) = x;
    
    symOutput = DecodeChromosome(chromosome);
    
    clc
    disp("g(x) = " + char(simplify(symOutput)))
    fprintf("error: %.6f\n", error);
    
    plot(data.input, output, 'LineWidth', 2)
    hold on
    plot(data.input, data.target, 'LineWidth', 2)
    legend('best fit', 'original data', 'FontSize', 10)
    ylabel('Output', 'FontSize', 17)
    xlabel('Input', 'FontSize', 17)
    hold off
end

