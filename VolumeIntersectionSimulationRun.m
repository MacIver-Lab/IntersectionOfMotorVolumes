%% Name: Volume Intersection Simulation Run
%  Description: runs volume intersection simulations for a range of initial
%               bend velocities, a range of times remaining, and single
%               propulsive velocity
% Author: Kiran Bhattacharyya (bhattacharyyakiran12@gmail.com)

%%
clear
addpath('data/', 'functions/');

%% generate parameters for simulation   
nSim = 5; % number of initial bend velocities to simulate 
load('InitialBendVelocities.mat') % load in measured initial bend velocties in deg/ms
initBendVelo = datasample(initBendVelocities, nSim, 'Replace', true); % sample measured velocities
                                                                      % with replacement

load('avgPropVelocities.mat') % load propulsive velocities during escape
propVelocity = mean(avgPropVelocities); % mean propulsive velcity in mm/ms

timeRemain = [7, 15, 20, 25, 35, 50]; % times remaining at escape to simulate fish motor volume

for ii = 1:nSim
    disp(['SIMULATING ANGULAR VELOCITY ' num2str(ii) ' OF ' num2str(nSim) '.'])
    [attackAzim, attackElev, intersectionProps] = VolumeIntersectionFunction(initBendVelo(ii), propVelocity, timeRemain, 0); 
    intersectionMeans(ii,:) = 1 - mean(intersectionProps);
end

%% plot results 
figure
errorbar(timeRemain, mean(intersectionMeans), std(intersectionMeans), 'o-')
axis([0 60 0 1])
pbaspect([1 1 1])
xticks(0:10:60)
xlabel('Time remaining (ms)')
ylabel('Not-engulfed proportion')
title('Volume intersection')