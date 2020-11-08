function output = Polynomial(polynomialCoefficients, input)
    output = 0;
    i = 0;
    for coefficient = polynomialCoefficients
        output = output + coefficient * input.^i;
        i = i + 1;
    end
end