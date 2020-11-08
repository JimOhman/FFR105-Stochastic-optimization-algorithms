function particles = UpdateParticles(particles, ...
                                     cognitiveComponent, ...
                                     socialComponent, ...
                                     xSwarmBest, ...
                                     xParticleBest, ...
                                     inertiaWeight, ...
                                     maxVelocity, ...
                                     timeStep)
    
    swarmShape = size(particles.positions);
    
    q = rand(swarmShape);
    cognitivePart = (xParticleBest - particles.positions) ./ timeStep;
    cognitivePart = cognitiveComponent .* q .* cognitivePart;
    
    r = rand(swarmShape);
    socialPart = (xSwarmBest - particles.positions) ./ timeStep;
    socialPart = socialComponent .* r .* socialPart;
    
    inertiaPart = inertiaWeight .* particles.velocities;
    particles.velocities =  inertiaPart + cognitivePart + socialPart;
    
    isAbove = particles.velocities > maxVelocity;
    particles.velocities(isAbove) = maxVelocity;
    
    isBelow = particles.velocities < -maxVelocity;
    particles.velocities(isBelow) = -maxVelocity;
    
    positionChanges = particles.velocities .* timeStep;
    particles.positions = particles.positions + positionChanges;

end