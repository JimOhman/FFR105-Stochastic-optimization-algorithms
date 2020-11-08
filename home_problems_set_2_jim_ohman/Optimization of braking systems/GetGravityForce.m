function gravityForce = GetGravityForce(slopeAngle, constants)
    gravityForce = constants.mass * constants.g * sind(slopeAngle);
end