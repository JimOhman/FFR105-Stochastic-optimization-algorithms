function visibility = GetVisibility(cityLocation)
    [numberOfCities, ~] = size(cityLocation);
    visibility = zeros(numberOfCities);
    for i = 1:numberOfCities
        city = cityLocation(i, :);
        for j = i+1:numberOfCities
            otherCity = cityLocation(j, :);
            visibility(i, j) = 1 / sqrt(sum((city - otherCity).^2, 2));
        end
    end
    visibility = visibility + transpose(visibility);
end