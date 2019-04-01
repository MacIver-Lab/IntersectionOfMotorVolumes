function [X_full, Y_full, Z_full] = maskPoints_maker(maskWidth)
% labiumPoints_maker            Given a labiumWidth, this function creates
%                               the points that will create the polyhedron
%                               representing the swept volume of mask
% 
% INPUTS 
% 
% maskWidth                     the width of the mask in mm, try 3.5 mm
%
% OUTPUTS
%
% X_full, Y_full, Z_full        3D points that compose the mask swept
%                               volume
%
% EXAMPLES
%  
% maskWidth = 3.5;
% [X_full, Y_full, Z_full] = maskPoints_maker(maskWidth)

    % position of labial mitt center
    % maskWidth width of labial mitt in mm
    labDepth = maskWidth*0.5; % depth of labial mitt in mm
    labLength = maskWidth*0.4; % length of labial mitt
    
    % define all axes of the quarter ellipse to approximate the labium
    ellipseAxis1 = maskWidth;
    ellipseAxis2 = labDepth*2;
    ellipseAxis3 = labLength*2;
    % create a set of points that make a sphere
    [x, y, z] = sphere;
    X = x(:);
    Y = y(:);
    Z = z(:);
    % get only quarter ellipse
    X = X(x(:) >= 0 & z(:) <= 0);
    Z = Z(x(:) >= 0 & z(:) <= 0);
    Y = Y(x(:) >= 0 & z(:) <= 0);
    % recenter near bottom of labium
    Z = Z + (labDepth/4);
    % center libial mitt
    X = X*(ellipseAxis3/2);
    Y = Y*(ellipseAxis1/2);
    Z = Z*(ellipseAxis2/2);
    
    % create mask swept volume 
    armLength = 6; % length of labial arm in mm 
    subY = Y(X >= 0 & X <= (labLength/10));
    subZ = Z(X >= 0 & X <= (labLength/10));
    Yarm = subY;
    Zarm = subZ;
    Xarm = -armLength*ones(size(subY));
    
    % create full set of points for mask
    X_full = [X;Xarm];
    Y_full = [Y;Yarm];
    Z_full = [Z;Zarm];
end