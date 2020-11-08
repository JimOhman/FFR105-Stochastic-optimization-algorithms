function fitnessValue = EvaluateIndividual(cityLocations, chromosome)
    locations = cityLocations(chromosome, :);
    x1 = locations;
    x2 = circshift(locations, 1);
    distances = sqrt(sum((x1 - x2).^2, 2));
    pathLength = sum(distances);
    fitnessValue = 1 / pathLength;
end
