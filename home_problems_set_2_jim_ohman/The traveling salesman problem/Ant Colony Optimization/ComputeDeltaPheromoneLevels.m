function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection, ...
                                                           pathLengthCollection)
    [numPaths, numberOfCities] = size(pathCollection);
    
    changes = (1 ./ pathLengthCollection);
    deltaPheromoneLevel = zeros(numberOfCities);

    for k = 1:numPaths
        path = pathCollection(k, :);
        shiftedPath = circshift(path, 1);
        idx = sub2ind(size(deltaPheromoneLevel), path, shiftedPath);
        deltaPheromoneLevel(idx) = deltaPheromoneLevel(idx) + changes(k);
    end
end