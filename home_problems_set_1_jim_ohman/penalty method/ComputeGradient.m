function gradient = ComputeGradient(x1, x2, penaltyParameter)
    penaltyPart = 4*penaltyParameter * max(x1^2 + x2^2 - 1, 0);
    gradX1 = 2*(x1-1) + penaltyPart * x1;
    gradX2 = 4*(x2-2) + penaltyPart * x2;
    gradient = [gradX1, gradX2];
end
