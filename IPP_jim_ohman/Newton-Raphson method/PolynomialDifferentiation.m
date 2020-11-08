function derivativeCoefficients = PolynomialDifferentiation(polynomialCoefficients, order)
    if order < 0
        error('the order must be non-negative')
    end
    
    if order == 0
        derivativeCoefficients = polynomialCoefficients;
        return
    end
    
    derivativeCoefficients = [];
    polynomialOrder = length(polynomialCoefficients) - 1;
    if polynomialOrder < order
        return
    end
    
    i = 0;
    for coefficient = polynomialCoefficients
        if i >= order
          for j = 1:order
            coefficient = coefficient * (i-j+1);
          end
          derivativeCoefficients = [derivativeCoefficients, coefficient];
        end
        i = i + 1;
    end
end