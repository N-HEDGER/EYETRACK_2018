function [Trialevents]=runSingleTrial(scr,const,Trialevents,my_key,text,sounds,eye,i)
% ----------------------------------------------------------------------
% [Trialevents]=runSingleTrial(scr,const,Trialevents,my_key,text,i)
% ----------------------------------------------------------------------
% Goal of the function :
% Draw stimuli of each indivual trial and collect inputs
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% my_key : structure containing keyboard configurations
% Trialevents: structure containing trial events
% text: structure containing text config.
% sounds: structure containing sounds.
% i: the trial number
% ----------------------------------------------------------------------
% Output(s):
% Trialevents : struct containing all the variable design configurations
% with data appended.
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     priming

%% Prepare stimuli
%  ---------------

% Trial-level variables;
trial.trialnum=num2str(Trialevents.trialmat(i,1));  
trial.stimtype=Trialevents.trialmat(i,2);
trial.scramtype=Trialevents.trialmat(i,3);
trial.duration=Trialevents.trialmat(i,4)/1000; 
%trial.Model=Trialevents.trialmat(i,5);

% Print the condition details to the external file.

log_txt=sprintf(text.formatSpecTrial,trial.trialnum,text.stimlabel{trial.stimtype},text.scramlabel{trial.scramtype},trial.duration);
fprintf(const.log_text_fid,'%s\n',log_txt);

const.trialsdone=trial.trialnum;

%% Drawings
    HideCursor;
    % Fixation dot;
    Screen('DrawDots',scr.main,scr.mid,const.bigfixsize,const.bigfixcol,[],1);
    Screen('DrawDots',scr.main,scr.mid,const.smallfixsize,const.smallfixcol,[],1);
    Screen('DrawDots',scr.main,scr.mid,const.smallerfixsize,const.smallerfixcol,[],1);
    
    sound(sounds.begin,sounds.beginf);
    
    Fixonset=Screen('Flip',scr.main,[1]);
    
    WaitSecs(0.3)
    % Stimulus

    
    tic
 
    
    gaze_data = eye.eyetracker.get_gaze_data();
    if trial.stimtype==1
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.stimrectl]);
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.stimrectr]);
    else
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.stimrectl]);
    Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.stimrectr]);
    end
    
    Screen('Flip', scr.main);
    eye.eyetracker.get_gaze_data();
    pause(trial.duration)

    
    
    collected_gaze_data=eye.eyetracker.get_gaze_data();
    eye.eyetracker.stop_gaze_data();
    %  Mask
    %Screen('DrawTexture',scr.main,const.tex.Frametex,[],[const.framerect]);
    %Screen('DrawTexture',scr.main,const.tex.Masktex{2,randi(100)},[],[const.maskrect]);
    M2onset=Screen('Flip',scr.main,[]);
   
 
    Trialevents.elapsed{i}=M2onset-Fixonset;
   
    
    t1=GetSecs;
    [KeyIsDown,secs,keyCode]=KbCheck;
     %Screen('Flip',scr.main,[targonset+const.targdur]);
    while keyCode(my_key.space)==0 && keyCode(my_key.escape)==0
        [KeyisDown,secs,keyCode]=KbCheck;
    end
    
    if keyCode(my_key.space)==1;
    elseif keyCode(my_key.escape)==1
        const.trialsdone=trial.trialnum;
        config.scr = scr; config.const = rmfield(const,'tex'); config.Trialevents = Trialevents; config.my_key = my_key;config.text = text;config.sounds = sounds,config.eye = eye;
        log_txt=sprintf(text.formatSpecQuit,num2str(clock));
        fprintf(const.log_text_fid,'%s\n',log_txt);
        save(const.filename,'config');
        save('gaze.mat','collected_gaze_data')
        ShowCursor(1);
        Screen('CloseAll')
    end
    
    %  Update progress bar.
    progvec=round(linspace(1,const.stimright,length(Trialevents.trialmat)));
    progbar=[0 7 progvec(str2num(const.trialsdone)) 17];
    %    Draw slider at new location
    Screen('FillRect', scr.main, const.blue, progbar);
    
    Screen('Flip', scr.main);
    
end