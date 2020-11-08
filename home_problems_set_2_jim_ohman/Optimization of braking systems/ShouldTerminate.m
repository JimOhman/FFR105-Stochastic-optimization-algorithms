function terminate = ShouldTerminate(breakTemp, velocity, constants)
    terminate = breakTemp > constants.maxTemp;
    terminate = terminate | velocity > constants.maxVelocity;
    terminate = terminate | velocity < constants.minVelocity;
end