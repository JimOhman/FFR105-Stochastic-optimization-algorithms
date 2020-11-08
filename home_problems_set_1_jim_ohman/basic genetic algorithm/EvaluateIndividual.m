function fitnessValue = EvaluateIndividual(x1, x2)
    f1 = (x1 + x2 + 1).^2;
    f2 = (19 - 14*x1 + 3*x1.^2 - 14*x2 + 6*x1.*x2 + 3*x2.^2);
    p1 = (2*x1 -3*x2).^2;
    p2 = (18 - 32*x1 + 12*x1.^2 + 48*x2 - 36*x1.*x2 + 27*x2.^2);
    fitnessValue = ((1 + f1.*f2) .* (30 + p1.*p2)).^(-1);
end
