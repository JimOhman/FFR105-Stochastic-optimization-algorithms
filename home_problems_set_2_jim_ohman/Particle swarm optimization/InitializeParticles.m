function particles = InitializeParticles(numberOfParticles, ...
                                         numberOfDimensions, ...
                                         xMin, xMax, ...
                                         timeStep, ...
                                         alpha)
                                     
    range = repmat(xMax - xMin, numberOfParticles, numberOfDimensions);
    
    r = rand(numberOfParticles, numberOfDimensions);
    positions = xMin + r .* range;
    
    r = rand(numberOfParticles, numberOfDimensions);
    velocities = (alpha/timeStep) * (-(range./2) + r .* range);
    
    particles = struct('positions', positions, 'velocities', velocities);
    
end