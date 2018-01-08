function [text]=textConfig
% ----------------------------------------------------------------------
% [text]=textconfig
% ----------------------------------------------------------------------
% Goal of the function :
% Define a structure for text items and text formats.
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
text.formatSpecTrialStart=('Trial start at: %s');
text.formatSpecTrialEnd=('Trial end at: %s');
text.formatSpecFlip1=('Textures flipped at: %s');
text.formatSpecFlip2=('Textures removed at: %s');
text.formatSpecQuit=('Subject quitted at: %s');
text.formatSpecReStart=('Subject restarted at: %s');
instruct='Take a good look at the images';
text.preload='LOADING STIMULI AND PREPARING TEXTURES';
text.loaded='STIMULI LOADED. PRESS ANY KEY TO BEGIN';
text.instruct=sprintf(instruct);
text.stimlabel={'social left','social right'};
text.scramlabel={'intact','scrambled'};
text.formatSpecTrial=('Trial %s Stimtype: %s Scram type: %s Duration: %s Pair: %s');
text.gazestart=('Gaze started to record at: %s');
text.gazestop=('Gaze stopped recording at: %s');
text.save=('Data saved at: %s');

end
