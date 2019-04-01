function MVshp = zebrafishMotorVolume_maker(initBendVelocity, initialPosition, timeRemain, propVelocity)
% zebrafishMotorVolume_maker    Given an intial bend velocity, an initial
%                               position, a time remaining and a propulsive
%                               velocity, this function creates a
%                               polyhedron object that is the 3D fish motor
%                               volume. NOTE: the fish always points in the
%                               positive y-direction.
% 
% INPUTS 
% 
% initBendVelocity              float defining the intial bend velocity of
%                               fish during the intial bend of the escape 
%                               in degrees/ms. Try 14.0
%
% initialPosition               initial position of the larval zebrafish in
%                               the x,y coordinate space. Try [0 0].
%
% timeRemain                    float or horizontal vector of floats
%                               defining the time remaining at escape which
%                               are used to create fish motor volumes, in
%                               ms. Try 25.0 
%
% propVelocity                  the propulsive velocity of the fish during
%                               the propulsive phase of the escape response
%                               in mm/ms. Try 0.12
%
% OUTPUTS
%
% MVshp                         represents a 3D polyhedron object in Matlab
%                               This polyhedron is the zebrafish motor
%                               volume
%
% EXAMPLES
%  
% initBendVelocity = 14;
% propVelocity = 0.12;
% timeRemain = 25;
% initialPosition = [0,0]
% MVshp = zebrafishMotorVolume_maker(initBendVelocity, initialPosition, timeRemain, propVelocity)

%% set up variables 
resolution = 0.1; % time resolution

xmin = -(timeRemain*propVelocity) - 2;
xmax = (timeRemain*propVelocity) + 2;
ymin = xmin;
ymax = xmax;
zmin = xmin;
zmax = xmax;

%% get time-distance volume
[X, Y, Z, Vol] = zebrafishMotorVolume_contour(initBendVelocity, propVelocity, resolution,...
    xmin, xmax, ymin, ymax, zmin, zmax);

%% grab those values of x,y,z points in 3D space that correspond to the 
%  time reamining of interest

[I, J, K] = ind2sub(size(Vol), find(Vol > (timeRemain - 1) & Vol < (timeRemain + 1)));

%% create shape of fish motor volume 
MVshp_pts = [X(I)', Y(J)', Z(K)'];
MVshp_pts = MVshp_pts + repmat([initialPosition, 0], size(MVshp_pts, 1), 1);
MVshp = alphaShape(MVshp_pts, 10);


end