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
% sounds : structure containing sounds
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0

% Sound played when stimuli are loaded.
[sounds.loaded,sounds.loadedf] = audioread('bring.wav');

% Sound played at start of trial
[sounds.begin,sounds.beginf] = audioread('kaching.wav');

% Sound played if eyetracker is found.
[sounds.eye,sounds.eyef] = audioread('cure.wav');

% Sound played if no eyetracker is found.
[sounds.noeye,sounds.noeyef] = audioread('beatrush.wav');

end