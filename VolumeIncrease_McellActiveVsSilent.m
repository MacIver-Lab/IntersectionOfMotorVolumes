%% Name: Increase in volume M-cell active vs silent
%  Description: Generates fish motor volumes for M-cell active and silent 
%               cases for different times remaining at escape and checks
%               the increase in motor volume for M-cell active cases.
% Author: Kiran Bhattacharyya (bhattacharyyakiran12@gmail.com)

%%
clear
addpath('data/', 'functions/');

%% generate parameters to run simulation
nSim = 10; % number of simulations to run (nSim = 50 for studies, but fewer simulations take less time)
initBendVel_Mcell = 18 + (5*rand(nSim,1).*(2*round(rand(nSim,1)) - 1)); % in deg/ms M-cell active bend velocity
initBendVel_nonM = 10 + (5*rand(nSim,1).*(2*round(rand(nSim,1)) - 1)); % in deg/ms M-cell silent bend velocity

initialPosition = [0,0]; % fish initial position in x,y axis

timeRemain = [7, 15, 20, 25, 35, 50]; % time remaining at escape in ms
mcellLarger = nan(nSim,size(timeRemain,2)); % create matrix to store data
%NOTE: each initial bend velocity is used to create a motor volume for
%      each time remaining. This increases the total number of simulations 
%      quickly. nSim * size(timeRemain,2);

load('avgPropVelocities.mat') % load propulsive velcoties
propVelocity = mean(avgPropVelocities); % propulsive velcity in mm/ms

for ii = 1:nSim
    for jj = 1:size(timeRemain,2)
        MVshp_mcell = zebrafishMotorVolume_maker(initBendVel_Mcell(ii), initialPosition, timeRemain(jj), propVelocity);
        MVshp_nonM = zebrafishMotorVolume_maker(initBendVel_nonM(ii), initialPosition, timeRemain(jj), propVelocity);
        intProp = zebrafishMV_engulfProp(MVshp_mcell, MVshp_nonM); % since M-cell active volume is larger, this determines
                                                                   % proportion of the M-cell active volume that the M-cell 
                                                                   % silent volume occupies.
        percentLarger = 100*((1/intProp) - 1); % how much larger is the M-cell active volume in percent
        mcellLarger(ii,jj) = percentLarger; % store value in matrix
    end
end

%% plot result 

figure
errorbar(timeRemain, mean(mcellLarger), std(mcellLarger)/sqrt(nSim), 'bo-')
axis([0 60 0 800])
pbaspect([1 1 1])
xticks(0:10:60)
xlabel('Time remaining (ms)')
ylabel('Percent (%)')
title('Increase in fish motor volume')