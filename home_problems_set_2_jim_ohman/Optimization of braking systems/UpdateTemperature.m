function breakTemp = UpdateTemperature(breakTemp, ...
                                       appliedPressure, ...
                                       constants)
    if appliedPressure < 0.01
        relativeTemp = (breakTemp - constants.ambientTemp);
        tempChange = -(relativeTemp / constants.tau);
    else
        tempChange = (constants.tempConstant * appliedPressure);
    end
    breakTemp = breakTemp + (tempChange * constants.timeStep);
    breakTemp = max(breakTemp, constants.ambientTemp);
end