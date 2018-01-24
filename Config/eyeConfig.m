function [eye]=eyeConfig(sounds)
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
% eye : structure containing textformats
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0

addpath(genpath('/Users/nickhedger/Downloads/TobiiPro.SDK.Matlab_1.2.1.54'))

eye.tobii = EyeTrackingOperations();
eye.eyetrackers = eye.tobii.find_all_eyetrackers();


if size(eye.eyetrackers)>0
    eye.eyetracker=eye.eyetrackers(1);
    if isa(eye.eyetracker,'EyeTracker')
        disp('Eye tracker l o c a t e d');
        sound(sounds.eye,sounds.eyef);
    end
else
     sound(sounds.noeye,sounds.noeyef);
     eye.eyetracker='NO EYETRACKER';
    
end

eye.tobii = EyeTrackingOperations();

end
