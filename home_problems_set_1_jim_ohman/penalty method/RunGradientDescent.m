function minimumPoint = RunGradientDescent(x1, x2, ...
                                           penaltyParameter, ...
                                           stepSize, ...
                                           tolerance)
    t = inf;
    while tolerance < t
        gradient = ComputeGradient(x1, x2, penaltyParameter);
        x1 = x1 - stepSize * gradient(1);
        x2 = x2 - stepSize * gradient(2);
        t = norm(gradient, 2);
    end
    minimumPoint = [x1, x2];
end