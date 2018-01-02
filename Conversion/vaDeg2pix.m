function [pixX,pixY]= vaDeg2pix(vaDeg,scr)
% ----------------------------------------------------------------------
% [pixX, pixY] = vaDeg2pix(vaDeg,scr)
% ----------------------------------------------------------------------
% Goal of the function :
% Convert visual angle (degree) in pixel ( x and y )
% ----------------------------------------------------------------------
% Input(s) :
% vaDeg = size in visual angle (deg)                   
% scr   = screen configurations : scr.scr_sizeX (pix)  
%                                 scr.scr_sizeY (pix)  
%                                 scr.disp_sizeX (mm)  
%                                 scr.disp_sizeY (mm)  
%                                 scr.dist (cm)       
% ----------------------------------------------------------------------
% Output(s):
% pixX  = size in pixel(X)                            
% pixY  = size in pixel(Y)                             
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : All
% ----------------------------------------------------------------------

cm= vaDeg2cm(vaDeg,scr);
[pixX,pixY] = cm2pix(cm,scr);
end
