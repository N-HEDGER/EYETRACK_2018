function [noiseim] = NOISEIM2 (startim,prop,isplot)
% ----------------------------------------------------------------------
% [image] = NOISEIM2 (startim,prop,isplot)
% ----------------------------------------------------------------------
% Goal of the function :
% Convert color image to noise image
% ----------------------------------------------------------------------
% Input(s) :
% image = starting rgb image            
% prop = proportion of pixels to apply the salt and pepper noise to       
% ----------------------------------------------------------------------
% Output(s):
% noiseim = noise image.                         
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : All
% Version : 1.0
% ----------------------------------------------------------------------

% Set up cell for R, G and B planes


RPLANE=cell(1,1);
GPLANE=cell(1,1);
BPLANE=cell(1,1);

for i=1:1    
RPLANE{i}=startim(:,:,1);
GPLANE{i}=startim(:,:,2);
BPLANE{i}=startim(:,:,3);
end

% Obtain the amplitude spectra of each of the planes
[RPLANE2,RSPEC]=specMatch(RPLANE);
[GPLANE2,GSPEC]=specMatch(GPLANE);
[BPLANE2,BSPEC]=specMatch(BPLANE);

% Create random noise of same size as the planes. Prop controls the 
% density of the noise e.g. 0.5 - noise is applied to half of the pixels. 
NOISE=cell(1,1);
NOISE{1}=imnoise(rgb2gray(startim),'salt & pepper',prop);
NOISE2{1}=imnoise(rgb2gray(startim),'salt & pepper',prop);
NOISE3{1}=imnoise(rgb2gray(startim),'salt & pepper',prop);
% Give the noise the same amplitude spectra as the R G and B planes from
% the image
[RNOISE]=specMatch(NOISE,0,RSPEC);
[GNOISE]=specMatch(NOISE2,0,GSPEC);
[BNOISE]=specMatch(NOISE3,0,BSPEC);

% Create new rgb image by combining the 3 noise images
NOISE=gray2rgb(RNOISE{1});
NOISE(:,:,1)=RNOISE{1};
NOISE(:,:,2)=GNOISE{1};
NOISE(:,:,3)=BNOISE{1};

% normalise.
noiseim=normalise(NOISE);
if isplot
subplot(1,2,1)
imshow(image)
subplot(1,2,2)
imshow(startim)
else
end