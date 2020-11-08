function handles = InitializeDrivingPlot(constants)
    figure('Units', 'Normalized', 'Position', [0.25, 0.25, 0.3, 0.6]);
    subplot(5, 1, 1)
    angleHandle = plot(NaN, NaN, 'LineWidth', 2);
    hold on
    angleMarker = plot(NaN, NaN, 'o', 'MarkerSize', 10, ...
                                      'Color', 'black');
    title('Slope angle', 'fontsize', 14)
    ylabel('$\alpha (x)$', 'fontsize', 17, 'interpreter', 'latex')
    xlim([0, constants.slopeLength])
    ylim([0, constants.maxAngle])
    hold on
    subplot(5, 1, 2)
    pressureHandle = plot(NaN, NaN, 'LineWidth', 2);
    hold on
    pressureMarker = plot(NaN, NaN, 'o', 'MarkerSize', 10, ...
                                          'Color', 'black');
    title('Applied pedal pressure', 'fontsize', 14)
    ylabel('$P_p(x)$', 'fontsize', 17, 'interpreter', 'latex')
    xlim([0, constants.slopeLength])
    ylim([0, 1])
    hold on
    subplot(5, 1, 3)
    gearHandle = plot(NaN, NaN, 'LineWidth', 2);
    hold on
    gearMarker = plot(NaN, NaN, 'o', 'MarkerSize', 10, ...
                                     'Color', 'black');
    title('Gear', 'fontsize', 14)
    ylabel('$G(x)$', 'fontsize', 17, 'interpreter', 'latex')
    xlim([0, constants.slopeLength])
    ylim([1, 10])
    hold on
    subplot(5, 1, 4)
    velocityHandle = plot(NaN, NaN, 'LineWidth', 2);
    hold on
    velocityMarker = plot(NaN, NaN, 'o', 'MarkerSize', 10, ...
                                         'Color', 'black');
    title('Velocity', 'fontsize', 14)
    ylabel('$V(x)$', 'fontsize', 17, 'interpreter', 'latex')
    xlim([0, constants.slopeLength])
    ylim([constants.minVelocity, constants.maxVelocity])
    hold on
    subplot(5, 1, 5)
    breakTempHandle = plot(NaN, NaN, 'LineWidth', 2);
    hold on
    temperatureMarker = plot(NaN, NaN, 'o', 'MarkerSize', 10, ...
                                            'Color', 'black');
    title('Break temperature', 'fontsize', 14)
    xlabel('$x$', 'fontsize', 17, 'interpreter', 'latex')
    ylabel('$T_b(x)$', 'fontsize', 17, 'interpreter', 'latex')
    xlim([0, constants.slopeLength])
    ylim([constants.ambientTemp, constants.maxTemp])
    hold on
    markers = struct('angle', angleMarker, ...
                     'pressure', pressureMarker, ...
                     'gear', gearMarker, ...
                     'velocity', velocityMarker, ...
                     'temperature', temperatureMarker);
    handles = struct('angleHandle', angleHandle, ...
                     'pressureHandle', pressureHandle, ...
                     'gearHandle', gearHandle, ...
                     'velocityHandle', velocityHandle, ...
                     'breakTempHandle', breakTempHandle, ...
                     'markers', markers);
end