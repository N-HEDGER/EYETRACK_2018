function [pixX, pixY] = cm2pix(cm,scr)
% ----------------------------------------------------------------------
% [pixX, pixY] = cm2pix(cm,scr)
% ----------------------------------------------------------------------
% Goal of the function :
% Convert cm in pixel ( x and y )
% ----------------------------------------------------------------------
% Input(s) :
% cm    = size in cm                                 
% scr   = screen configurations
% ----------------------------------------------------------------------
% Output(s):
% pixX  = size in pixel(X)                             
% pixY  = size in pixel(Y)                              
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : All
% Version : 1.0
% ----------------------------------------------------------------------


pix_by_mmX = scr.scr_sizeX/scr.disp_sizeX;
pix_by_mmY = scr.scr_sizeY/scr.disp_sizeY;

pixX = cm.*10.*pix_by_mmX;
pixY = cm.*10.*pix_by_mmY;

end