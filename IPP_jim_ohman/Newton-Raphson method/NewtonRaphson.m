function iterationPoints = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
    if length(polynomialCoefficients) < 3
        error('polynomial order must be larger than 1')
    end
    
    firstDerivativeCoefficients = PolynomialDifferentiation(polynomialCoefficients, 1);
    secondDerivativeCoefficients = PolynomialDifferentiation(firstDerivativeCoefficients, 1);
    
    iterationPoints = [startingPoint];
    
    T = Inf;
    while tolerance < T
        iterationPoint = iterationPoints(end);
        
        firstDerivativeValue = Polynomial(firstDerivativeCoefficients, iterationPoint);
        secondDerivativeValue = Polynomial(secondDerivativeCoefficients, iterationPoint);
        
        nextIterationPoint = NewtonRaphsonStep(iterationPoint, firstDerivativeValue, secondDerivativeValue);
        
        iterationPoints = [iterationPoints, nextIterationPoint];
        T = abs(nextIterationPoint - iterationPoint);
    end
end