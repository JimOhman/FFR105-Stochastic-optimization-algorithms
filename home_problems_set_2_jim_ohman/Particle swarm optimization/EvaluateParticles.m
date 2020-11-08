function value = EvaluateParticles(particles)
    x = particles.positions(:, 1);
    y = particles.positions(:, 2);
    value = FunctionToOptimize(x, y);
end