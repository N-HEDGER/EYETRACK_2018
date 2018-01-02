function [cm] = vaDeg2cm (vaDeg,scr)
% ----------------------------------------------------------------------
% [cm] = vaDeg2cm (vaDeg,dist)
% ----------------------------------------------------------------------
% Goal of the function :
% Convert visual angle (degree) in cm
% ----------------------------------------------------------------------
% Input(s) :
% vaDeg = size in visual angle (degree)             
% scr  = screen configuration : scr.dist(cm)       
% ----------------------------------------------------------------------
% Output(s):
% cm    = size in cm                               
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : All
% Version : 1.0
% ----------------------------------------------------------------------

cm = (2*scr.dist*tan(0.5*pi/180))*vaDeg;
end