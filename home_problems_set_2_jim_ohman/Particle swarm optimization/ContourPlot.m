function ContourPlot
    range = -5:0.1:5;
    [x, y] = meshgrid(range);
    z = FunctionToOptimize(x, y);
    contour(x, y, log(0.01 + z), 40);
    xlabel("x", "FontSize", 17)
    ylabel("y", "FontSize", 17)
end