function [matchedim] = MATCHCOL (startim,lum,con)
% ----------------------------------------------------------------------
% [image] = [noiseim] = MATCHCOL (startim,lum,con)
% ----------------------------------------------------------------------
% Goal of the function :
% Adjust the luminance and contrast of color image
% ----------------------------------------------------------------------
% Input(s) :
% image = starting rgb image            
% lum = luminance
% con = contrast
% ----------------------------------------------------------------------
% Output(s):
% matchedim = matched image                        
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : All
% Version : 1.0
% ----------------------------------------------------------------------

% Convert to hsv space
hsvim=rgb2hsv(startim);
% Get value plane
hsvim(:,:,3)=(hsvim(:,:,3)-mean2(hsvim(:,:,3)))/std2(hsvim(:,:,3))*con+lum;

matchedim=hsv2rgb(hsvim);


end