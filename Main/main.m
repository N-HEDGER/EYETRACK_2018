function main(const)
% ----------------------------------------------------------------------
% main(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Launch all functions of the experiment
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing a some constant configuration
% ----------------------------------------------------------------------
% Output(s):
% none
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0
% ----------------------------------------------------------------------

if const.oldsub==0 % Is this an old subject?
    
% Screen configurations
% ---------------------
[scr] = scrConfig(const);

% Keyboard configurations
% -----------------------
[my_key] = keyConfig;

% Text configurations
% -----------------------
[text] = textConfig;


% Experimental constant
% ---------------------
[const] = constConfig(scr,const);

% Experimental design
% -------------------
[Trialevents] = designConfig(const);

% Audio
% -------------------
[sounds] = soundConfig;


else
    scr=const.config.scr;
    my_key=const.config.my_key;
    text=const.config.text;
    Trialevents=const.config.Trialevents;
    const=rmfield(const,'config')
end


const.log_text_fid=fopen(const.txtfilename,'a+');

% Open screen window

% ------------------
Screen('Preference', 'SkipSyncTests', 1); 
[scr.main,scr.rect] = Screen('OpenWindow',scr.scr_num,const.background_color,[], scr.clr_depth,2);
priorityLevel = MaxPriority(scr.main);Priority(priorityLevel);
DrawFormattedText(scr.main, text.instruct, 'justifytomax', 100, WhiteIndex(scr.main),[],[]);
PAS=im2uint8(imread('instructstim.jpg'));
const.tex.PAStex=Screen('MakeTexture', scr.main,PAS);
Screen('DrawTexture',scr.main,const.tex.PAStex,[],[500 500 1000 1000]);
% Update the display to show the instruction text:
Screen('Flip', scr.main);
KbWait
DrawFormattedText(scr.main, 'STARTING', 'justifytomax', 100, WhiteIndex(scr.main),[],[]);
Screen('Flip', scr.main);

% % Trial runner
% % ------------
runTrials(scr,const,Trialevents,my_key,text);
% 


end