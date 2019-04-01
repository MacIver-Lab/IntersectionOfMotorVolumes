%% Visualize zebrafish motor volumes for Mauthner and non-Mauthner escapes
%  Description: Visualized M-cell active and silent zebrafish motor volumes
%               for different times remaining at escape
% Author: Kiran Bhattacharyya (bhattacharyyakiran12@gmail.com)

%%
clear
addpath('data/', 'functions/');

%% set M-cell active and silent parameters 
Mcell_initBendVel = 20; % deg/ms
nonM_initBendVel = 10; % deg/ms

load('avgPropVelocities.mat') % load propulsive velcoties
propVelocity = mean(avgPropVelocities); % propulsive velcity in mm/ms
Mcell_propVelocity = propVelocity;
nonM_propVelocity = propVelocity;

initialPosition = [0 0];

timeRemain = [15, 30, 45];

orange = [255 165 0]/255;
volumeColor = [0 0 1; 0 1 0; orange];

axLimits = 7;

az = 270;
el = 0;

%% plot mauthner fish volumes 
figure
for ii = 1:size(timeRemain, 2)
    subplot(1,3,ii)
    % get fish volume shape
    MVshp = zebrafishMotorVolume_maker(Mcell_initBendVel, initialPosition, timeRemain(ii), Mcell_propVelocity);

    % plot results 
    s = plot(MVshp);
    s.FaceColor = volumeColor(ii,:);
    s.FaceAlpha = 0.5;
    s.EdgeColor = 'none';
    
    axis equal
    axis([-axLimits axLimits -axLimits axLimits -axLimits axLimits])
    title(['Mauther cell active, t = ' num2str(timeRemain(ii)) ' ms'])
    grid off
    view(az,el)
    
    light('Position',[0 0 6],'Style','local')
    camlight(0,45)
    material shiny
    lighting gouraud
end

%% plot non-mauthner fish volumes 
figure
for ii = 1:size(timeRemain, 2)
    subplot(1,3,ii)
    % get fish volume shape
    MVshp = zebrafishMotorVolume_maker(nonM_initBendVel, initialPosition, timeRemain(ii), nonM_propVelocity);

    % plot results 
    s = plot(MVshp);
    s.FaceColor = volumeColor(ii,:);
    s.FaceAlpha = 0.5;
    s.EdgeColor = 'none';
    
    axis equal
    axis([-axLimits axLimits -axLimits axLimits -axLimits axLimits])
    title(['Mauther cell silent, t = ' num2str(timeRemain(ii)) ' ms'])
    grid off
    view(az,el)
    
    light('Position',[0 0 6],'Style','local')
    camlight(0,45)
    material shiny
    lighting gouraud
end
