function pathLength = GetPathLength(path, cityLocations)
    locations = cityLocations(path, :);
    x1 = locations;
    x2 = circshift(locations, 1);
    distances = sqrt(sum((x1 - x2).^2, 2));
    pathLength = sum(distances);
end
