% General experimenter launcher %%
%  ============================= 
% By :      Nicholas Hedger
% Project:  Eyetracking 2018
% With :    Bhisma Chakrabarti
% Version:  1.0
% The main file that drives the experiment.

% First settings 
% --------------
clear vars;clear mex;clear functions;close all;home;ListenChar(1);

% Desired screen settings
% -----------------------
const.desiredFD      = 60;                  % Desired refresh rate
const.desiredRes    = [1280,1024];          % Desired resolution

% Mode
% -----------------------
const.debug = 1;% Whether to print the trial information to the command window.
const.calibrating=0;
    

% Path     
% ----
 dir = (which('expLauncher'));cd(dir(1:end-18));

% Add paths
% ---------------
addpath('Config','Main','Stim','Trial','Data','Conversion','Misc','GUI');

% Initial eyetracker check
% ---------------
addpath(genpath('/Users/nickhedger/Downloads/TobiiPro.SDK.Matlab_1.2.1.54'))

tobii = EyeTrackingOperations();
eyetrackers = tobii.find_all_eyetrackers();
if size(eyetrackers)>0
    eyetracker=eyetrackers(1);
    if isa(eyetracker,'EyeTracker')
        disp('Eye tracker l o c a t e d');
    end
else
     eyetracker='NO EYETRACKER';
     prompt=input('No eye tracker has been detected, would you like to continue anyway? (1=yes, 0=no)');
     if prompt==0
         error('Re-connect the eye tracker or re-start MATLAB');
         clear all
     else
     end
end


% Subject configuration     
% ---------------------
[const] = sbjConfig(const);
  
% Main run. Main is the function that runs all the config functions.
% ---------
main(const);