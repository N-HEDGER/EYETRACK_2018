function [const] = sbjConfig(const)
% ----------------------------------------------------------------------
% [const]=sbjConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define subject configurations (initials, gender...)
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
sbj=RunExp;
const.sbj=sbj;
const.isfixed=const.sbj.isfixed;
const.filename=strcat('Data/',const.sbj.subname{1},'.mat');
const.txtfilename=strcat('Data/',const.sbj.subname{1},'.txt');

if exist(const.filename)
   datafilename=const.filename
    clearvars -except datafilename
    load(datafilename)
    
     X = [' You have done ',(config.const.trialsdone),' trials'];
    disp(X)
    % Ask for response.
    Q1=input('That filename already exists. You have done the above number of trials in this session, correct [0= no, 1= yes]');
if Q1==0
        %         If incorrect, chose different initials.
        error('something has gone wrong. Please choose a different filename')
else
const=config.const;
const.oldsub=1;
const.config=config;
const.starttrial=str2num(const.trialsdone);
end

else
const.oldsub=0;
const.starttrial=1;
end
end