function [X, Y, Z, Vol] = zebrafishMotorVolume_contour(initBendVelocity, propVelocity, resolution,...
    xmin, xmax, ymin, ymax, zmin, zmax)
% zebrafishMotorVolume_contour      Given an initial bend velocity, a
%                                   propulsive velocity, a time
%                                   resolution, and bounds in x, y, and z
%                                   to define a 3D volume, this a
%                                   3D matrix where each element is the
%                                   time needed to reach a point in 3D
%                                   space defined by the values in the
%                                   index of vectors X, Y, and Z.
% 
% INPUTS
%
% initBendVelocity                  Initial bend velocity in deg/ms. 
%                                   Try 14 
% 
% propVelocity                      velocity of propulsive stage in mm/ms. 
%                                   Try 0.12
%       
% resolution                        time resolution
%
% xmin, xmax, ymin...               bounds defining 3D volume 
%
% NOTE: fish is pointing in the positive y-direction
%
% OUTPUTS
% 
% X                                 points in the x direction 
%       
% Y                                 points in the y direction 
%       
% Z                                 points in the z direction 
%       
% Vol                               a 3D matrix where each element 
%                                   represents the time needed to reach a 
%                                   point in 3D space defined by the values 
%                                   in the index of vectors X, Y, and Z. 

%% define X, Y, Z values and matrix to be populated
X = xmin:resolution:xmax;
Y = ymin:resolution:ymax;
Z = zmin:resolution:zmax; 
Vol = zeros(size(X,2), size(Y,2), size(Z,2));

%% loop through each point and calculate how long it would take to reach 
%  that point
for ii = 1:size(X, 2)
    for jj = 1:size(Y, 2)
        for kk = 1:size(Z, 2)
            thisPoint = [X(ii), Y(jj), Z(kk)];
            thisPoint_mag = sqrt(sum(thisPoint.^2, 2));
            thisPoint_unit = thisPoint/thisPoint_mag; 
            thisPoint_ang = acosd(dot([0 1 0], thisPoint_unit));
            thisPoint_stg1 = thisPoint_ang/(0.95*initBendVelocity);
            thisPoint_stg3 = thisPoint_mag/propVelocity;
            Vol(ii,jj,kk) = thisPoint_stg1 + thisPoint_stg3;
        end
    end
end