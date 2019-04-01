# functions

This subdirectory contains the functions that are used by the code in the main directory to make the relevant visualizations of motor volumes. 

## File details

maskPoints_maker.m<br/>
Creates the points that will be used to make the mask swept volume. 

maskVolume_maker.m<br/>
Creates the 3D polyhedron representing the mask swept volume. Uses the output of maskPoints_maker

VolumeIntersectionFunction.m<br/>
Runs volume intersection simulations for a range of initial bend velocities, a range of times remaining, and single propulsive velocity

zebrafishMotorVolume_contour.m<br/>
Given an initial bend velocity, a propulsive velocity, a time resolution, and bounds in x, y, and z to define a 3D volume, this returns a 3D matrix where each element is the time needed to reach a point in 3D space defined by the values in the index of vectors X, Y, and Z.

zebrafishMotorVolume_maker.m<br/>
Given an intial bend velocity, an initial position, a time remaining and a propulsive velocity, this function creates a 3D polyhedron object that is the fish motor volume. 

zebrafishMV_engulfProp.m<br/>
Given a fish motor volume and a mask swept volume, the function returns the proportion of the fish motor volume intersected by the mask swept volume.

For additional details on code please read comments within each file. 
