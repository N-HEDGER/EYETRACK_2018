function [scr]=scrConfig(const)
% ----------------------------------------------------------------------
% [scr]=scrConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define configuration relative to the screen
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% scr : struct containing screen configurations
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0
% ----------------------------------------------------------------------

% Number of the exp screen:
scr.all = Screen('Screens');
scr.scr_num = max(scr.all);

% Screen resolution (pixel) :
[scr.scr_sizeX, scr.scr_sizeY]=Screen('WindowSize', scr.scr_num);

% Physical size of the display :
scr.disp_sizeX = 340;scr.disp_sizeY=270; 

% Pixels size:
scr.clr_depth = Screen('PixelSize', scr.scr_num);

% Frame rate : (fps)
scr.frame_duration =1/(Screen('FrameRate',scr.scr_num));

% Frame rate : (hertz)
scr.hz = 1/(scr.frame_duration);
 if (scr.hz >= 1.1*const.desiredFD || scr.hz <= 0.9*const.desiredFD);
    % error('Incorrect refresh rate => Please restart the program after changing the refresh rate to %i Hz',const.desiredFD);
 end


% Subject viewing distance.
scr.dist = 65;             

% Center of the screen :
scr.x_mid = (scr.scr_sizeX/2.0);
scr.y_mid = (scr.scr_sizeY/2.0);
scr.mid = [scr.x_mid,scr.y_mid];

