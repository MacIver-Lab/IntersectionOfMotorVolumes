function intProp = zebrafishMV_engulfProp(MVshp, MaskVolume)
% VolumeIntersectionFunction    Given fish motor volume and labium swept
%                               volume, this returns the proportion of the
%                               fish motor volume intersected with the mask
%                               swept volume.
% 
% INPUTS 
% 
% MVshp                         3D polyhedron representing fish motor
%                               volume
%
% MaskVolume                    3D polyhedron representing the mask swept
%                               volume
%
% OUTPUTS
%
% initProp                      the proportion of the fish motor volume
%                               engulfed by the mask swept volume 
%
% EXAMPLES
%  
% % make mask swept volume
% maskWidth = 3.5;
% [X_full, Y_full, Z_full] = maskPoints_maker(maskWidth)
% xyangle = 90;
% xzangle = 0;
% MaskVolume = maskVolume_maker(X_full, Y_full, Z_full, xyangle, xzangle)
% % make fish motor volume
% initBendVelocity = 14;
% propVelocity = 0.12;
% timeRemain = 25;
% initialPosition = [0,0]
% MVshp = zebrafishMotorVolume_maker(initBendVelocity, initialPosition, timeRemain, propVelocity)
% % run command 
% intProp = zebrafishMV_engulfProp_3(MVshp, MaskVolume)


    % generate points in fish MV
    numOfPts = 100000; % number of points the generate in fish motor volume
    dimMins = min(MVshp.Points);
    dimMaxs = max(MVshp.Points);
    dimRange = dimMaxs - dimMins;
    myRandPts = (rand(numOfPts, 3).*repmat(dimRange, numOfPts, 1))...
        + repmat(dimMins, numOfPts, 1);
    tf_bigMV = inShape(MVshp, myRandPts(:,1), myRandPts(:,2), myRandPts(:,3));
    tf_MV = tf_bigMV;
    myRandPts_inMV = myRandPts(tf_MV, :); % number of points in the fish motor volume
    
    % see if points are in the mask swept volume 
    myRandPts_inMask = inShape(MaskVolume, myRandPts_inMV(:,1), myRandPts_inMV(:,2), myRandPts_inMV(:,3));
    intProp = sum(myRandPts_inMask)/size(myRandPts_inMV, 1); 
end