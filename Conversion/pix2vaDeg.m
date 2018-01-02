function [vaDeg]= pix2vaDeg (pix,scr)
% ----------------------------------------------------------------------
% [vaDeg]= pix2vaDeg (pix,scr)
% ----------------------------------------------------------------------
% Goal of the function :
% Convert pixel in visual angle
% ----------------------------------------------------------------------
% Input(s) :
% pix   = size in pixel                             
% scr   = screen configurations : scr.scr_sizeX (pix)  
%                                 scr.scr_sizeY (pix)  
%                                 scr.disp_sizeX (mm)  
%                                 scr.disp_sizeY (mm)  
%                                 scr.dist (cm)        
% ----------------------------------------------------------------------
% Output(s):
% vaDeg = size in visual angle (degree)               
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Last edit
% Project : All
% Version : 1.0
% ----------------------------------------------------------------------

[cmX,cmY]=pix2cm(pix,scr);
[vaDeg] = cm2vaDeg([cmX,cmY],scr);

end
