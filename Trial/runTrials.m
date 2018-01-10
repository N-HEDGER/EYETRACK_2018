function runTrials(scr,const,Trialevents,my_key,text,sounds,eye,gaze)
% ----------------------------------------------------------------------
% runTrials(scr,const,Trialevents,my_key,text)
% ----------------------------------------------------------------------
% Goal of the function :
% Launch each trial.
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% my_key : structure containing keyboard configurations
% Trialevents: structure containing trial events
% text: structure containing text config.
% sound: structure containing sounds

% ----------------------------------------------------------------------
% Output(s):
% none
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : Eyetracking 2018

% ----------------------------------------------------------------------

%% Make all textures

% The path is outside the repo, because we don't want to upload all of
% that.
addpath(genpath('/Users/nickhedger/Documents/Temp/Eyetrack_stim'))

 STIMIN=load('intact_matched.mat'); % Intact stimuli
 STIMSC=load('scrambled_matched.mat'); % Scrambled stimuli.

 dims=size(STIMIN.ims);
 ntypes=dims(1); % Types of stimuli (intact, scrambled)
 nstim=dims(2); % Instances (40).
 
 STIMIN=STIMIN.ims;
 STIMSC=STIMSC.ims2;
 
 for t=1:ntypes
     for s=1:nstim
     STIMIN{t,s}=imresize(im2uint8(STIMIN{t,s}),[const.element_size round(const.element_size*const.asp)]);
     const.tex.stim{t,s}=Screen('MakeTexture', scr.main,STIMIN{t,s});
     STIMSC{t,s}=imresize(im2uint8(STIMSC{t,s}),[const.element_size round(const.element_size*const.asp)]);
     const.tex.stimsc{t,s}=Screen('MakeTexture', scr.main,STIMSC{t,s});
     
     end
 end


% Frames
 Frametex=im2uint8(randn(const.element_size+const.framewidth,round(const.element_size*const.asp)+const.framewidth)); % Random-dot frame.
 const.tex.Frametex=Screen('MakeTexture', scr.main,Frametex);
 const.progrect=CenterRect(const.progBar, scr.rect)-[0 500 0 500];
  
% Define Rects
[const.framerectl] = CenterRect([0 0 round(const.element_size)+const.framewidth round(const.element_size*const.asp)+const.framewidth], scr.rect)-[const.sep 0 const.sep 0];
[const.framerectr] = CenterRect([0 0 round(const.element_size)+const.framewidth round(const.element_size*const.asp)+const.framewidth], scr.rect)+[const.sep 0 const.sep 0];
[const.stimrectl] = CenterRect([0 0 round(const.element_size) round(const.element_size*const.asp)], scr.rect)-[const.sep 0 const.sep 0];
[const.stimrectr] = CenterRect([0 0 round(const.element_size) round(const.element_size*const.asp)], scr.rect)+[const.sep 0 const.sep 0];
instruct=im2uint8(imread('instruct.png'));
const.tex.instruct=Screen('MakeTexture', scr.main,instruct);
%% Experimental loop
if const.oldsub==0
log_txt=sprintf(text.formatSpecStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);
Trialevents.elapsed=cell(1,length(Trialevents.trialmat));

else
    
log_txt=sprintf(text.formatSpecReStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);
    
end

sound(sounds.loaded,sounds.loadedf);

Screen('DrawTexture',scr.main,const.tex.instruct,[],[0, 0,scr.scr_sizeX, scr.scr_sizeY]);
DrawFormattedText(scr.main, text.loaded, 'justifytomax', 100, WhiteIndex(scr.main),[],[]);
Screen('Flip', scr.main);
KbWait;

for i = const.starttrial:length(Trialevents.trialmat);

% Run single trial
log_txt=sprintf(text.formatSpecTrialStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);

[const,Trialevents,eye,text] = runSingleTrial(scr,const,Trialevents,my_key,text,sounds,eye,i,gaze);

log_txt=sprintf(text.formatSpecTrialEnd,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);

WaitSecs(const.ITI);    
    
end

Screen('CloseAll');

% Dont save any textures.
const.tex=[];
config.scr = scr; config.const = const; config.Trialevents = Trialevents; config.my_key = my_key;config.text = text; config.sounds = sounds; config.eye=eye;config.gaze=gaze;
save(const.filename,'config');

% End messages
% ------------

end