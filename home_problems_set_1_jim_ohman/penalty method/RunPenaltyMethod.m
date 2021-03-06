function RunPenaltyMethod
    gradientDescentTolerance = 10^(-6);
    gradientDescentStepSize = 0.0001;
    penaltyParameters = [0, 1, 10, 100, 1000];
    
    plot = false;
    
    numberOfPenaltyParameters = length(penaltyParameters);
    results = zeros(numberOfPenaltyParameters, 3);
    
    startingPoint = [1, 2];
    results(1, 1:3) = [penaltyParameters(1), startingPoint];
    
    x1 = startingPoint(1);
    x2 = startingPoint(2);
    for i = 2:numberOfPenaltyParameters
        penaltyParameter = penaltyParameters(i);

        minimumPoint = RunGradientDescent(x1, x2, ... 
                                          penaltyParameter, ...
                                          gradientDescentStepSize, ...
                                          gradientDescentTolerance);
                                      
        x1 = minimumPoint(1);
        x2 = minimumPoint(2);

        results(i, 1:3) = [penaltyParameter, x1, x2];
    end
    
    varNames = {'Penalty parameter', 'x1*', 'x2*'};
    disp(array2table(results, 'VariableNames', varNames))
    
    if plot
        figure('Units', 'Normalized', 'Position', [0.25, 0.25, 0.3, 0.6]);
        [x, y] = meshgrid(-3:0.2:3, -3:0.2:3);
        z = (x-1).^2 + 2*(y-2).^2;
        surf(x, y, z)
        hold on

        theta = 0:0.1:(2*pi + 0.05);
        x = cos(theta);
        y = sin(theta);
        z = (x-1).^2 + 2*(y-2).^2;
        plot3(x, y, z, 'color', 'k', 'LineWidth', 2.5)

        x = results(:, 2);
        y = results(:, 3);
        z = (x-1).^2 + 2*(y-2).^2 + 0.2;
        plot3(x, y, z, '-wo','LineWidth', 1.5, ...
                       'MarkerEdgeColor', 'k', ...
                       'MarkerFaceColor', 'white', ...
                       'MarkerSize', 10)

        title('Application of the penalty method', 'fontsize', 15)
        xlabel('$x_1$', 'Interpreter', 'latex', 'fontsize', 15)
        ylabel('$x_2$', 'Interpreter', 'latex', 'fontsize', 15)
        zlabel('$f(x_1, x_2)$', 'Interpreter', 'latex', 'fontsize', 15)
        legend('$f(x_1, x_2) = (x_1-1)^2 + 2(x_2-1)^2$', ...
               '$x_1^2 + x_2^2 = 1$', ...
               '$(x_1^*$, $x_2^*)_\mu$', ...
               'Interpreter', 'latex', ...
               'fontsize', 12, ...
               'Location', 'south')
        
        hold off
    end
end