function PSO22
    
    numberOfDimensions = 2;
    xMin = -5;
    xMax = 5;
    
    numberOfIterations = 1000;
    numberOfParticles = 20;
    timeStep = 0.1;
    inertiaWeight = 1.4;
    inertiaWeightDecay = 0.99;
    minInertiaWeight = 0.4;
    maxVelocity = (xMax -xMin) / timeStep;
    cognitiveComponent = 2.;
    socialComponent = 2.;
    alpha = 1;
    
    animate = false;
    verbose = true;
    
    particles = InitializeParticles(numberOfParticles, ...
                                    numberOfDimensions, ...
                                    xMin, xMax, ...
                                    timeStep, ...
                                    alpha);
    
    if animate              
        figure('Units', 'Normalized', 'Position', [0.25, 0.25, 0.3, 0.6]);
        range = -5:0.3:5;
        [x, y] = meshgrid(range);
        z = FunctionToOptimize(x, y);
        surf(x, y, z);
        xlabel('$x$', 'fontsize', 17, 'interpreter', 'latex')
        ylabel('$y$', 'fontsize', 17, 'interpreter', 'latex')
        zlabel('$f(x, y)$', 'fontsize', 17, 'interpreter', 'latex')
        xlim([-5, 5])
        ylim([-5, 5])
        zlim([-100, 200])

        hold on;
        populationHandle = scatter3(0, 0, 0, 'o', ...
                                             'MarkerFaceColor', 'white', ...
                                             'SizeData', 100);
        hold off;
    end      
                                  
    xSwarmBest = zeros(numberOfParticles, numberOfDimensions);
    valueSwarmBest = inf;
    xParticleBest = zeros(numberOfParticles, numberOfDimensions);
    valueParticleBest = inf * ones(numberOfParticles, 1);

   	for i = 1:numberOfIterations
        values = EvaluateParticles(particles);
        [minValue, minIndex] = min(values);
        if minValue < valueSwarmBest
            valueSwarmBest = minValue;
            xSwarmBest = particles.positions(minIndex, :);
        end
        
        isBest = values < valueParticleBest;
        xParticleBest(isBest, :) = particles.positions(isBest, :);
        valueParticleBest(isBest) = values(isBest);

        particles = UpdateParticles(particles, ...
                                    cognitiveComponent, ...
                                    socialComponent, ...
                                    xSwarmBest, ...
                                    xParticleBest, ...
                                    inertiaWeight, ...
                                    maxVelocity, ...
                                    timeStep);
        
        inertiaWeight = inertiaWeightDecay * inertiaWeight;
        inertiaWeight = max(inertiaWeight, minInertiaWeight);
        
        if verbose
            clc
            x = xSwarmBest(1, 1);
            y = xSwarmBest(1, 2);
            f = valueSwarmBest;
            fprintf("x=%.6f, y=%.6f, f=%.6f\n", x, y, f);
        end
        
        if animate
            x = particles.positions(:, 1);
            y = particles.positions(:, 2);
            z = FunctionToOptimize(x, y);
            set(populationHandle, 'XData', x, 'YData', y, 'ZData', z);
            drawnow;
            pause(0.1);
        end
    end
end













