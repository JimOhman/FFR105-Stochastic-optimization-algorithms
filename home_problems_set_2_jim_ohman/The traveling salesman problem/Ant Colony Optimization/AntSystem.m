%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = numberOfCities;
alpha = 1.;
beta = 2.;
rho = 0.5;

nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation);
tau0 = numberOfAnts/nearestNeighbourPathLength;

targetPathLength = 123;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0);
visibility = GetVisibility(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iMsg = 'Iteration %d, ant %d: path length = %.5f\n';

iIteration = 0;

while (minimumPathLength > targetPathLength)
    iIteration = iIteration + 1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate paths:
    %%%%%%%%%%%%%%%%%%%%%%%%%%

    pathCollection = [];
    pathLengthCollection = [];

    for k = 1:numberOfAnts
        path = GeneratePath(pheromoneLevel, visibility, alpha, beta);
        pathLength = GetPathLength(path, cityLocation);
        if (pathLength < minimumPathLength)
            minimumPathLength = pathLength;
            fprintf(iMsg, iIteration, k, minimumPathLength);
            title(num2str(pathLength))
            PlotPath(connection, cityLocation, path);
        end
        pathCollection = [pathCollection; path];           
        pathLengthCollection = [pathLengthCollection; pathLength];
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Update pheromone levels
    %%%%%%%%%%%%%%%%%%%%%%%%%%

    deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection, ...
                                                      pathLengthCollection);
    pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel, ...
                                           deltaPheromoneLevel, ...
                                           rho);
end






