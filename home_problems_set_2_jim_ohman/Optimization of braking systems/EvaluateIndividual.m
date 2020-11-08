function fitnessValue = EvaluateIndividual(individual, ...
                                           constants, ...
                                           iSlopes, ...
                                           iDataSet, ...
                                           plot, ...
                                           animate)
    
    
    if plot || animate
        handles = InitializeDrivingPlot(constants);
    end
    
    numSlopes = length(iSlopes);
    fitnessValues = zeros(1, numSlopes);
    for i = 1:numSlopes
        iSlope = iSlopes(i);
        
        position = constants.initialPosition;
        breakTemp = constants.initialBreakTemp;
        velocity = constants.initialVelocity;
        gear = constants.initialGear;
        
        timeElapsed = 0;
        gearChangedTime = 0;
        velocitySum = 0;
        stepsTaken = 1;
        
        if plot || animate
            drivingData = struct('angles', [], ...
                                 'pressures', [], ...
                                 'gears', [], ...
                                 'velocities', [], ...
                                 'temperatures', [], ...
                                 'positions', []);
            j = 1;
        end
        
        while position < constants.slopeLength

            velocitySum = velocitySum + velocity;
            
            slopeAngle = GetSlopeAngle(position, iSlope, iDataSet);
            
            networkInput = GetNetworkInput(velocity, ...
                                           slopeAngle, ...
                                           breakTemp, ...
                                           constants);
            
            networkOutput = Network(networkInput, individual);
            
            appliedPressure = networkOutput(1);
            
            if plot || animate
                drivingData.angles(j) = slopeAngle;
                drivingData.pressures(j) = appliedPressure;
                drivingData.gears(j) = gear;
                drivingData.velocities(j) = velocity;
                drivingData.temperatures(j) = breakTemp;
                drivingData.positions(j) = position;
                j = j + 1;
            end
            
            if (timeElapsed - gearChangedTime) > 2 || gearChangedTime == 0
                gearChange = networkOutput(2);
                newGear = UpdateGear(gear, gearChange);
                if newGear ~= gear
                    gearChangedTime = timeElapsed;
                    gear = newGear;
                end
            end

            if animate
                UpdateDrivingPlot(handles, drivingData)
            end
            
            position = UpdatePosition(position, ...
                                      velocity, ...
                                      slopeAngle, ...
                                      constants);
            
            acceleration = GetAcceleration(slopeAngle, ...
                                           gear, ...
                                           appliedPressure, ...
                                           breakTemp, ...
                                           constants);
            
            velocity = UpdateVelocity(velocity, ...
                                      acceleration, ...
                                      constants);

            breakTemp = UpdateTemperature(breakTemp, ...
                                          appliedPressure, ...
                                          constants);
            
            if ShouldTerminate(breakTemp, velocity, constants)
                break
            end
            
            timeElapsed = timeElapsed + constants.timeStep;
            stepsTaken = stepsTaken + 1;
        end
        fitnessValues(i) = (velocitySum * position) / stepsTaken;
        
        if plot
            UpdateDrivingPlot(handles, drivingData)
        end
        
    end
    fitnessValue = mean(fitnessValues);
end








