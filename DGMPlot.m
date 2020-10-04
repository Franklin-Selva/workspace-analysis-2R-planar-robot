function DGMPlot(l1, l2, th1, th2, color)
    % 2R Planar robot
    % Plots the workspace for given link lengths and joint limits
    X = l1 .* cos(th1) + l2 .* cos(th1 + th2);
    Y = l1 .* sin(th1) + l2 .* sin(th1 + th2);
    plot(X, Y, color)
end
