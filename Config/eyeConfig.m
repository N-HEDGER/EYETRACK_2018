function [eyetrack]=eyeConfig
% ----------------------------------------------------------------------
% [eyetrack]=eyeConfig
% ----------------------------------------------------------------------
% Goal of the function :
% Define a structure for the eyetracker config.
% ----------------------------------------------------------------------
% Input(s) :
% none
% ----------------------------------------------------------------------
% Output(s):
% text : structure containing textformats
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0

addpath(genpath('/Users/nickhedger/Downloads/TobiiPro.SDK.Matlab_1.2.1.54'))

eye.tobii = EyeTrackingOperations();

end
