function breakingForce = GetBreakingForce(appliedPressure, ...
                                          temperatureOfBreaks, ...
                                          constants)
    breakingForce = (constants.mass * constants.g / 20) * appliedPressure;
    decayTemp = (constants.maxTemp - 100);
    if temperatureOfBreaks > decayTemp
        decayWeight = exp(-(temperatureOfBreaks - decayTemp)/100);
        breakingForce = breakingForce * decayWeight;
    end
end