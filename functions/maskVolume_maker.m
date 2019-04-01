function MaskVolume = maskVolume_maker(X_full, Y_full, Z_full, xyangle, xzangle)
% VolumeIntersectionFunction    given the points that compose the mask,
%                               the attack azimuth, and elevation this
%                               function creates the mask swept volume
% 
% INPUTS 
% 
% X_full, Y_full, Z_full        3D points representing the mask swept
%                               volume, output of maskPoints_maker
%
% xyangle                       attack azimuth of the mask in degrees
%
% xzangle                       attack elevation of the mask in degrees
%
% OUTPUTS
%
% MaskVolume                    3D polyhedron representing the mask swept
%                               volume
%
%
% EXAMPLES
%  
% maskWidth = 3.5;
% [X_full, Y_full, Z_full] = maskPoints_maker(maskWidth)
% xyangle = 90;
% xzangle = 0;
% MaskVolume = maskVolume_maker(X_full, Y_full, Z_full, xyangle, xzangle)

    Alpha     = 10;
    % rotate points in the xy and yz plane 
    rotMat_xz = [cosd(xzangle), -sind(xzangle);sind(xzangle), cosd(xzangle)];
    rotXZ = rotMat_xz*[X_full';Z_full'];
    X_rot = rotXZ(1,:)';
    Z_rot = rotXZ(2,:)';
    rotMat_xy = [cosd(xyangle), -sind(xyangle);sind(xyangle), cosd(xyangle)];
    rotXY = rotMat_xy*[X_rot';Y_full'];
    X_rot = rotXY(1,:)';
    Y_rot = rotXY(2,:)';
    % create 3D polyheadron of mask swept volume
    MaskVolume = alphaShape(X_rot, Y_rot, Z_rot, Alpha);

end