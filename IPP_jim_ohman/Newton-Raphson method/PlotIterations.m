function PlotIterations(polynomialCoefficients, iterationPoints)
    hold on
    
    longestPoint = max(abs(iterationPoints));
    xRange = -longestPoint:0.1:longestPoint;
    polynomialValues = Polynomial(polynomialCoefficients, xRange);
    plot(xRange, polynomialValues, ...
         'LineWidth', 1.5, ...
         'Color', 'black')
    
    IterationValues = Polynomial(polynomialCoefficients, iterationPoints);
    plot(iterationPoints, IterationValues, 'mo', ...
         'LineWidth', 2, ...
         'MarkerEdgeColor', 'k', ...
         'MarkerFaceColor', [.49 1 .63], ...
         'MarkerSize', 7);
    
    yline(0)
    xlabel('x')
    ylabel('f(x)')
    title('Applied Newton-Raphson method')
    
    hold off
end
