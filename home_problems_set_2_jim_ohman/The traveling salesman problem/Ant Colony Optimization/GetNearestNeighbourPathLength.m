function nnPathLength = GetNearestNeighbourPathLength(cityLocations)
    path = zeros(1, length(cityLocations));
    notVisited = 1:length(cityLocations);
    
    visiting = randsample(notVisited, 1);
    for i = 1:length(cityLocations)
        notVisited(notVisited == visiting) = [];
        path(:, i) = visiting;
        city = cityLocations(visiting, :);

        minDistance = inf;
        for j = 1:length(notVisited)
            otherCity = cityLocations(notVisited(j), :);
            distance = sqrt(sum((city-otherCity).^2));
            if distance < minDistance
                minDistance = distance;
                visiting = notVisited(j);
            end
        end
    end
    nnPathLength = GetPathLength(path, cityLocations);
end
