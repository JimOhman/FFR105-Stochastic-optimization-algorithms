function nextIterationPoint = NewtonRaphsonStep(iterationPoint, firstDerivativeValue, secondDerivativeValue)
    if secondDerivativeValue == 0
        msg = sprintf('%s%d','second derivative was zero at x = ', iterationPoint);
        error(msg)
    end
    nextIterationPoint = iterationPoint - firstDerivativeValue / secondDerivativeValue;
end