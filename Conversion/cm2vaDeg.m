function [vaDeg] =cm2vaDeg (cm,scr)
% ----------------------------------------------------------------------
% [vaDeg] = cm2vaDeg(cm,scr)
% ----------------------------------------------------------------------
% Goal of the function :
% Convert cm in visual angle (degree)
% ----------------------------------------------------------------------
% Input(s) :
% cm = size in cm                                   
% scr  = screen configuration : scr.dist(cm)        
% ----------------------------------------------------------------------
% Output(s):
% vaDeg = size in visual angle (degree)            
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : All
% Version : 1.0
% ----------------------------------------------------------------------

vaDeg = cm./(2*scr.dist*tan(0.5*pi/180));
end
