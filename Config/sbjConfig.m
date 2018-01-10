function [const] = sbjConfig(const)
% ----------------------------------------------------------------------
% [const]=sbjConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define subject configurations (initials, gender...).
% Runs a GUI for inputting subject info.
% Flags whether the filename already exists and if true, starts from where 
% they left off
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0
% ----------------------------------------------------------------------

% GUI elements

sbj=struct();
sbj=RunExp; % Runs a GUI for inputting subject details.
const.sbj=sbj;
const.isfixed=const.sbj.isfixed;
mkdir(strcat('Data/',const.sbj.subname{1},'/const/'));
mkdir(strcat('Data/',const.sbj.subname{1},'/log/'));
mkdir(strcat('Data/',const.sbj.subname{1},'/gaze/'));

const.filename=strcat('Data/',const.sbj.subname{1},'/const/',const.sbj.subname{1},'.mat'); % Filename for mat file.
const.txtfilename=strcat('Data/',const.sbj.subname{1},'/log/',const.sbj.subname{1},'_log.txt'); % Filename for log file
const.gazefilename=strcat('Data/',const.sbj.subname{1},'/gaze/',const.sbj.subname{1}); % Filename for gaze data file

if exist(const.filename) % If the filename exists, get rid of everything else.
    datafilename=const.filename
    clearvars -except datafilename
    load(datafilename) % Load the file.
    
    X = [' You have done ',(config.const.trialsdone),' trials']; % Display the number of trials done.
    disp(X)
    % Ask for response.
    Q1=input('That filename already exists. You have done the above number of trials,  correct [0= no, 1= yes]');
    if Q1==0
        % If incorrect, chose different initials.
        error('something has gone wrong. Please choose a different filename')
    else
        % If correct, proceed from the trial where the subject last finished.
        const=config.const;
        const.oldsub=1;
        const.config=config;
        const.starttrial=str2num(const.trialsdone);
    end
    
else % If the filename doesnt exist, then start at trial 1.
    const.oldsub=0;
    const.starttrial=1;
end
end