%% Visualize predator and prey volume intersections
%  Description: Visualize intersections for fish motor volume and mask
%               swept volume.
% Author: Kiran Bhattacharyya (bhattacharyyakiran12@gmail.com)

%%
clear
addpath('data/', 'functions/');

%% make mask swept volume
maskWidth = 3.5;
[X_full, Y_full, Z_full] = maskPoints_maker(maskWidth);
xyangle = 90;
xzangle = 0;
MaskVolume = maskVolume_maker(X_full, Y_full, Z_full, xyangle, xzangle);

%% make fish motor volume
initBendVelocity = 14;
propVelocity = 0.12;
timeRemain = 30;
initialPosition = [0,0];
MVshp = zebrafishMotorVolume_maker(initBendVelocity, initialPosition, timeRemain, propVelocity);

%% get 3D fish model 
load('3DFishBody.mat');

%% plot result 
axLimits = 5;

b = plot(fishBody); % plot fish body for orientation
b.FaceColor = 'b';
b.FaceAlpha = 0.2;
b.EdgeColor = 'none';
hold on 

f = plot(MVshp); % plot fish motor volume
f.FaceColor = 'r';
f.FaceAlpha = 0.5;
f.EdgeColor = 'none';

n = plot(MaskVolume); % plot mask swept volume
n.FaceColor = 'g';
n.FaceAlpha = 0.5;
n.EdgeColor = 'none';

axis equal
axis([-axLimits axLimits -axLimits axLimits -axLimits axLimits])
grid on

light('Position',[0 0 6],'Style','local')
camlight(0,45)
material shiny
lighting gouraud

legend('Initial fish position', 'Fish motor volume', 'Mask swept volume')
xlabel('X (mm)')
ylabel('Y (mm)')
zlabel('Z (mm)')
title('Time remaining at escape: 30 ms')