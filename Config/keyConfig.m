function [my_key]=keyConfig
% ----------------------------------------------------------------------
% [my_key]=keyConfig
% ----------------------------------------------------------------------
% Goal of the function :
% Unify key names and define structure containing each key names
% ----------------------------------------------------------------------
% Input(s) :
% none
% ----------------------------------------------------------------------
% Output(s):
% my_key : structure containing keyboard configurations
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0
% ----------------------------------------------------------------------
KbName('UnifyKeyNames');                 
my_key.escape   =   KbName('ESCAPE');
my_key.space    =   KbName('Space');
end