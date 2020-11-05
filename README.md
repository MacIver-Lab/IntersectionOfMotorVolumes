# Intersection of motor volumes predicts the outcome of ambush predation of larval zebrafish
This is the Matlab code needed to perform the fish motor volume and mask swept volume simuations contained within the study "Intersection of motor volumes predicts the outcome of ambush predation of larval zebrafish" by Kiran Bhattacharyya, David McLean, and Malcolm MacIver (Under review, Journal of Experimental Biology). 

The files in the main directory (details below) repeat the simulations used to generate the panels in Figure 7. All files use functions that can be found in the *functions* subdirectory. Some files also use some of the data that was collected in the study which can be found in the *data* subdirectory. NOTE: Only the data relevant for the motor volume simulations are found in the *data* subdirectory. 

## Directions

This code was developed and tested on Matlab 2018a. Certain native Matlab functions vital to creating and operating on 3D polyhedrons including "alphaShape" and "inShape" were both introduced in Matlab 2014b. You will need Matlab 2014b or a later version to run this code. Download [Matlab](https://www.mathworks.com/products/matlab.html).

After cloning or downloading repo including subdirectories. Start Matlab and set the working directory. It is recommended that you run "VisualizeVolumeIntersections.m" first since this is the least computationally expensive and tests that all major functions to ensure that the other code will run on the machine. 

## File details 

Visualize_fishMotorVolume_McellActiveVsSilent.m<br/>
Visualizes the fish motor volume for M-cell active and silent cases. Replicates the visualization in Figure 7D.

VisualizeVolumeIntersections.m<br/>
Visualizes the volume intersection of the fish motor volume and the mask swept volume. Replicates the visualization in Figure 7B.

VolumeIncrease_McellActiveVsSilent.m<br/>
Generates fish motor volumes for M-cell active and silent cases for different times remaining at escape and checks the increase in motor volume for M-cell active cases. Runs the simulation that produces Figure 7E.

VolumeIntersectionSimulationRun.m<br/>
Generates many virtual fish motor volumes and intersects them with mask swept volumes approaching from different directions to determine the non-engulfed fraction of the fish motor volume. Runs simulation that produces Figure 7C.

VolumeIntersectionSimulationRun_McellActiveVsSilent.m<br/>
Generates many virtual fish motor volumes for M-cell active and silent cases and intersects them with mask swept volumes approaching from different directions to determine the non-engulfed fraction of the fish motor volume for each case. Runs simulation that produced Figure 7F and 7G.

For additional details on code please read comments within each file. For additional detials on *functions* and *data*, please browse those subdirectories.  


 


