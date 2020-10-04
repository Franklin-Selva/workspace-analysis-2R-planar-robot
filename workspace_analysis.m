clc; close all; clear all

%Solving for singularity points
%theta 2 should not have 0 deg or 180 deg
%theta 1 can be anything from 0 to 360 deg

%Joint lengths and limits
l1 = 1;
l2 = 1;
th1Limit = 132;
th2Limit = 141;

%Parameters for obstacle
xCircle = 2.;
yCircle = 3;
radius = 0.3;

%Test for collision b/w link 1 and link 2

testT1 = 0;
testT2 = 45;

testCollision(l1, l2, deg2rad(testT1), deg2rad(testT2), xCircle, yCircle, radius);
testX1 = l1*cos(deg2rad(testT1));
testY1 = l1*sin(deg2rad(testT1));
testX2 = testX1 + l2 * cos(deg2rad(testT1 + testT2));
testY2 = testY1 + l2 * sin(deg2rad(testT1 + testT2));

X = [0 testX1 testX2];
Y = [0 testY1 testY2];

%Plotting 
figure(1);
hold on;
grid on;
title("Workspace Analysis of 2R planar robot")
xlabel('x-axis') 
ylabel('y-axis') 
xlim([-4*l1 4*l1])
ylim([-4*l1 4*l1])
axis square

% Plotting obstacle and test case
plot(0, 0,"r*");
viscircles([xCircle yCircle],radius,'Color',"k");
plot(X, Y, "k");

% Considering limits for joint 1
th1 = deg2rad(-th1Limit);
th2 = deg2rad([-th2Limit:1:th2Limit]);
DGMPlot(l1, l2, th1, th2, "b")

th1 = deg2rad(th1Limit);
th2 = deg2rad([-th2Limit:1:th2Limit]);
DGMPlot(l1, l2, th1, th2, "g")

% Considering limits for joint 2
th1 = deg2rad([-th1Limit:1:th1Limit]);
th2 = deg2rad(-th2Limit);
DGMPlot(l1, l2, th1, th2, "r")

th1 = deg2rad([-th1Limit:1:th1Limit]);
th2 = deg2rad(th2Limit);
DGMPlot(l1, l2, th1, th2, "k")


% Singularity conditions
th1 = deg2rad([-th1Limit:1:th1Limit]);
th2 = deg2rad(0);
DGMPlot(l1, l2, th1, th2, "k--")

th1 = deg2rad([-th1Limit:1:th1Limit]);
th2 = deg2rad(180);
DGMPlot(l1, l2, th1, th2, "k--")