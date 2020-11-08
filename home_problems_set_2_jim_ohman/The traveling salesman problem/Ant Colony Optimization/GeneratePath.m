function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    [numCities, ~] = size(pheromoneLevel);
    cityWeights = (pheromoneLevel.^alpha) .* (visibility.^beta);
    
    path = zeros(1, numCities);
    notVisited = 1:numCities;
    startingCity = randperm(numCities, 1);
    notVisited(notVisited == startingCity) = [];
    
    city = startingCity;
    for i = 1:(numCities-2)
        path(:, i) = city;
        weights = cityWeights(notVisited, city);
        nextCity = randsample(notVisited, 1, true, weights);
        notVisited(notVisited == nextCity) = [];
        city = nextCity;
    end
    path(:, end-1) = city;
    path(:, end) = notVisited;
end