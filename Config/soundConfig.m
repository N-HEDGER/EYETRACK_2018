function [sounds]=soundConfig
% ----------------------------------------------------------------------
% [eyetrack]=eyeConfig
% ----------------------------------------------------------------------
% Goal of the function :
% Define a structure for the sounds.
% ----------------------------------------------------------------------
% Input(s) :
% none
% ----------------------------------------------------------------------
% Output(s):
% text : structure containing sounds
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0

[sounds.loaded,sounds.loadedf] = audioread('bring.wav');
[sounds.begin,sounds.beginf] = audioread('kaching.wav');

end