%% Name: Volume Intersection Simulation Run: M-cell active vs silent
%  Description: runs volume intersection simulations for a range of initial
%               bend velocities specific to M-cell active and silent escape
%               responses, a range of times remaining, and single
%               propulsive velocity 
% Author: Kiran Bhattacharyya (bhattacharyyakiran12@gmail.com)

%%
clear
addpath('data/', 'functions/');

%% generate range of initial bend velocities 
nSim = 10; % number of simulations to run
initBendVel_Mcell = 18 + (5*rand(nSim,1).*(2*round(rand(nSim,1)) - 1)); % in deg/ms M-cell active bend velocity
initBendVel_nonM = 10 + (5*rand(nSim,1).*(2*round(rand(nSim,1)) - 1)); % in deg/ms M-cell silent bend velocity

timeRemain = [7, 15, 20, 25, 35, 50]; % time remaining at escape in ms

load('avgPropVelocities.mat') % load propulsive velcoties
propVelocity = mean(avgPropVelocities); % propulsive velcity in mm/ms

for ii = 1:nSim
    disp(['SIMULATING ANGULAR VELOCITY ' num2str(ii) ' OF ' num2str(nSim) '.'])
    [attackAzim, attackElev, intersectionProps] = VolumeIntersectionFunction(initBendVel_Mcell(ii), propVelocity, timeRemain, 0); 
    intersectionMeans_Mcell(ii,:) = 1 - mean(intersectionProps);
    [attackAzim, attackElev, intersectionProps] = VolumeIntersectionFunction(initBendVel_nonM(ii), propVelocity, timeRemain, 0); 
    intersectionMeans_nonMcell(ii,:) = 1 - mean(intersectionProps);
end

%% plot results 
figure
hold on 
errorbar(timeRemain, mean(intersectionMeans_Mcell)*100, std(intersectionMeans_Mcell)*100, 'bo-')
errorbar(timeRemain, mean(intersectionMeans_nonMcell)*100, std(intersectionMeans_nonMcell)*100, 'ro-')
axis([0 60 0 100])
pbaspect([1 1 1])
xticks(0:10:60)
xlabel('Time remaining (ms)')
ylabel('Non-engulfed proportion')
title('Volume intersection')

%% compute survival benefit conferred by M-cell responses 
survProb_nonMcell = 1 - intersectionMeans_nonMcell;
survProb_Mcell = 1 - intersectionMeans_Mcell; 
survDiff = survProb_Mcell - survProb_nonMcell;
survIncr = survDiff./survProb_nonMcell;
survIncr(isnan(survIncr)) = 0; 

%% plot results
figure 
errorbar(timeRemain, mean(survIncr)*100, std(survIncr)*100, 'o-')
axis([0 60 0 150])
pbaspect([1 1 1])
xticks(0:10:60)
yticks(0:30:150)
xlabel('Time remaining (ms)')
ylabel('Percent change (%)')
title('Benefit of M-cell activation')