function [cmX,cmY] = pix2cm(pix,scr)
% ----------------------------------------------------------------------
% [cmX,cmY] = pix2cm(pix,scr)
% ----------------------------------------------------------------------
% Goal of the function :
% Convert pix in cm ( x and y )
% ----------------------------------------------------------------------
% Input(s) :
% pix   = size in pixel                                
% scr   = screen configurations : scr.scr_sizeX (pix)  
%                                 scr.scr_sizeY (pix)  
%                                 scr.disp_sizeX (mm)  
%                                 scr.disp_sizeY (mm)  
% ----------------------------------------------------------------------
% Output(s):
% cmX  = size in cm(X)                            
% cmY  = size in cm(Y)                             
% ----------------------------------------------------------------------
% Fuction created by Nick Hedger
% Project : All
% Version : 1.0
% ----------------------------------------------------------------------
pix_by_mmX = scr.scr_sizeX/scr.disp_sizeX;
pix_by_mmY = scr.scr_sizeY/scr.disp_sizeY;
cmX = pix./pix_by_mmX./10;
cmY = pix./pix_by_mmY./10;
end