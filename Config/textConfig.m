function [text]=textConfig
% ----------------------------------------------------------------------
% [text]=textconfig
% ----------------------------------------------------------------------
% Goal of the function :
% Define a structure for text items.
% ----------------------------------------------------------------------
% Input(s) :
% none
% ----------------------------------------------------------------------
% Output(s):
% text : structure containing textformats
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0
% ----------------------------------------------------------------------
text.formatSpecStart=('Subject started at: %s');
text.formatSpecTexture=('Textures drawn at: %f');
text.formatSpecFlip=('Textures flipped at: %f');
text.formatSpecResponse=('Response made at: %f');
text.formatSpecQuit=('Subject quitted at: %s');
text.formatSpecReStart=('Subject restarted at: %s');
instruct='Take a good look at the images';
text.instruct=sprintf(instruct);
text.stimlabel={'social','nonsocial'};
text.scramlabel={'intact','scrambled'};
text.durlabel={};
text.targmorphstrengthlabel={'low','high'};
text.formatSpecTrial=('Trial %s Stimtype: %s Scram type: %s Duration: %s');

end
