function TestProgram

    %% This program will automatically run the best individual from
    %% the optimization on a slope from the validation DataSet. To run on 
    %% your own slope, simply add your slope in GetSlopeAngle.m in the same
    %% format as the others with its own iDataSet and iSlope. These indices
    %% have to be specified below to run on the new slope.
    
    bestIndividual = load('bestIndividual.mat'); % loads the best individual
    constants = load('constants.mat'); % loads the driving conditions
    
    plot = true; % specify true if a plot is desired
    animate = false; % specify true if animation is desired
    
    iDataSet = 2; % defines the dataset index.
    iSlopes = 1; % defines the slope indexes for the given dataset.

    for iSlope = iSlopes
        fitness = EvaluateIndividual(bestIndividual, ...
                                     constants, ...
                                     iSlope, ...
                                     iDataSet, ...
                                     plot, ...
                                     animate);
        msg = "iDataSet: %.f, iSlope: %.f, fitness: %.2f\n";
        fprintf(msg, iDataSet, iSlope, fitness);
    end
end
