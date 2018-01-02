function runTrials(scr,const,Trialevents,my_key,text,sound)
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
% Masks
Masks=load('MasksS.mat');
Masks=Masks.noiseim;
Masks2=cell(1,length(Masks));
for t=1:length(Masks)
    Masks2{t}=imresize(im2uint8(Masks{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.Masktex{1,t}=Screen('MakeTexture', scr.main,imadjust(Masks2{t},stretchlim(Masks2{t})));
    const.tex.Masktex{2,t}=Screen('MakeTexture', scr.main,imcomplement(imadjust(Masks2{t},stretchlim(Masks2{t}))));
end

% Stimuli
STIMULI=load('STIMULI.mat');
STIMULIsc=load('STIMULIsc.mat');


for t=1:10
    STIMULI{1,t}=imresize(im2uint8(STIMULI{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.STIMULItex{1,t}=Screen('MakeTexture', scr.main,coladjust(STIMULI{1,t},const.element_lum,const.element_con));
    STIMULIsc{1,t}=imresize(im2uint8(STIMULIsc{t}),[const.element_size round(const.element_size*const.asp)]);
    const.tex.STIMULIsctex{1,t}=Screen('MakeTexture', scr.main,coladjust(STIMULIsc{1,t},const.element_lum,const.element_con));
    
end


% Frames
 Frametex=im2uint8(randn(const.element_size+const.framewidth,round(const.element_size*const.asp)+const.framewidth));
 const.tex.Frametex=Screen('MakeTexture', scr.main,Frametex);
 const.tex.Greytex=Screen('MakeTexture', scr.main, im2uint8(repmat(0.5,const.element_size,const.element_size*round(const.asp))));
 const.progrect=CenterRect(const.progBar, scr.rect)-[0 500 0 500];
  
% Define Rects
[const.framerect,dh,dv] = CenterRect([0 0 round(const.element_size*const.asp)+const.framewidth const.element_size+const.framewidth], scr.rect);
[const.maskrect,dh,dv] = CenterRect([0 0 round(const.element_size*const.asp) const.element_size], scr.rect);
[const.stimrect,dh,dv] = CenterRect([0 0 round(const.element_size*const.asp) round(const.element_size)], scr.rect);



%% Experimental loop
if const.oldsub==0
log_txt=sprintf(text.formatSpecStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);
Trialevents.elapsed=cell(1,length(Trialevents.trialmat));
Trialevents.awResp=zeros(1,length(Trialevents.trialmat));
Trialevents.AFCresp=cell(1,length(Trialevents.trialmat));
Trialevents.AFCresp2=cell(1,length(Trialevents.trialmat));
Trialevents.morph=zeros(1,length(Trialevents.trialmat));


else
    
log_txt=sprintf(text.formatSpecReStart,num2str(clock));
fprintf(const.log_text_fid,'%s\n',log_txt);
    
end


sound(sounds.loaded,sounds.loadedf);
DrawFormattedText(scr.main, 'PRESS ANY KEY TO BEGIN', 'justifytomax', 100, WhiteIndex(scr.main),[],[]);
Screen('Flip', scr.main);
KbWait;

 for i = const.starttrial:length(Trialevents.trialmat);

% Run single trial
[Trialevents] = runSingleTrial(scr,const,Trialevents,my_key,text,i);

WaitSecs(const.ITI);
    
config.scr = scr; config.const = rmfield(const,'tex'); config.Trialevents = Trialevents; config.my_key = my_key;config.text = text;
config.sound = sound;

save(const.filename,'config');
    
    
end

Screen('CloseAll');

% Dont save any textures.
const.tex=[];
config.scr = scr; config.const = const; config.Trialevents = Trialevents; config.my_key = my_key;config.text = text;
save(const.filename,'config');

% End messages
% ------------

end