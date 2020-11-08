function acceleration = GetAcceleration(slopeAngle, ...
                                        gear, ...
                                        appliedPressure, ...
                                        breakTemp, ...
                                        constants)
                                
    gravityForce = GetGravityForce(slopeAngle, constants);
    engineForce = GetEngineForce(gear, constants);
    breakingForce = GetBreakingForce(appliedPressure, breakTemp, constants);
    totalForce = (gravityForce - breakingForce - engineForce);
    
    acceleration = (totalForce / constants.mass);

end