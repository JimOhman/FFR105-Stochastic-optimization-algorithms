function velocity = UpdateVelocity(velocity, acceleration, constants)
    velocity = velocity + (acceleration * constants.timeStep);
end