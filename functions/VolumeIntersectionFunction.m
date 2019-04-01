function [attackAzim, attackElev, intersectionProps] = VolumeIntersectionFunction(initBendVelocity, propVelocity, timeRemain,... 
                                                            verbose)
% VolumeIntersectionFunction  Given an intial bend velocity, a propulsive
%                               velocity, and a value or horizontal vector 
%                               of times remaining at escape, the function
%                               returns the proportion of the fish motor
%                               volume intersected by the mask swept volume
%                               for different directions of the mask attack
% 
% INPUTS 
% 
% initBendVelocity              float defining the intial bend velocity of
%                               fish during the intial bend of the escape 
%                               in degrees/ms. Try 14.0
%
% propVelocity                  the propulsive velocity of the fish during
%                               the propulsive phase of the escape response
%                               in mm/ms. Try 0.12
%
% timeRemain                    float or horizontal vector of floats
%                               defining the time remaining at escape which
%                               are used to create fish motor volumes, in
%                               ms
%
% verbose                       boolean indicating if the user wants extra
%                               output, 0 or 1
%
% OUTPUTS
%
% attackAzim                    the azimuth of the mask attack with respect
%                               to the orientation of the fish, in degrees
% 
% attackElev                    the elevation of the mask attack with 
%                               respect to the orientation of the fish, in 
%                               degrees
%
% intersectionProps             matrix of values denoting the proportion of
%                               fish motor volume intersected by the mask 
%                               mask swept volume where the rows correspond
%                               to specific nymph attack directions and the
%                               columns refer to each time remaining value
%                               provided as input.
%
%
% EXAMPLES
%  
% initBendVelocity = 14;
% propVelocity = 0.12;
% timeRemain = 25;
% [attackAzim, attackElev, intersectionProps] = VolumeIntersectionSimulation_2(initBendVelocity, propVelocity, timeRemain)

warning off

%% create points that define the mask
labWidth = 3.5; % mask width in mm
[X_full, Y_full, Z_full] = maskPoints_maker(labWidth); % create points for mask

%% create meshgrid of angles that define attack positions of the mask
labXYAng = -90:90:90; % from behind, the side, and from front
labXZAng = -45:45:45; % from above, at plane, and below
[xyang, xzang] = meshgrid(labXYAng, labXZAng);
XYAng = xyang(:);
XZAng = xzang(:);
attackAzim = XYAng;
attackElev = XZAng;

%% loop through attack angle positions and create mask swept volumes
myLabiumVols = cell(size(XZAng));
for ii = 1:size(XZAng, 1)
    thisXYAng = XYAng(ii);
    thisXZAng = XZAng(ii);
    LabiumVol = maskVolume_maker(X_full, Y_full, Z_full, thisXYAng, thisXZAng); % rotate and position points to make labium volume
    myLabiumVols{ii} = LabiumVol;
end

%% run volume intersection simulations
totalSims = size(timeRemain, 2)*size(XYAng, 1); % total number of simulations to run

iter = 0;
dataMat = zeros(size(XYAng,1), size(timeRemain, 2)); % create matrix to store the intersection proportion of volumes
for tt = 1:size(timeRemain, 2)
    % get fish motor volume
    MVshp = zebrafishMotorVolume_maker(initBendVelocity, [0 0], timeRemain(tt), propVelocity);
    % loop through each attack position of the dragonfly nympy mask
    for jj = 1:size(XYAng, 1)
        iter = iter + 1;
        if verbose == 1
            tic;
            disp(['Performing simulation ' num2str(iter) ' of ' num2str(totalSims)])
        end
        LabiumVol = myLabiumVols{jj}; % grab mask orientation
        intProp = zebrafishMV_engulfProp(MVshp, LabiumVol); % find intersection of volumes
        dataMat(jj,tt) = intProp; % store intersection proportion in matrix 
        if verbose == 1 
            disp(['Simulation took ' num2str(toc) ' seconds.'])
        end
    end
end

intersectionProps = dataMat; % set as output of function

warning on


