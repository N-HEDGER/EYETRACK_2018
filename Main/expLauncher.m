% General experimenter launcher %%
%  =============================  %
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
const.debug = 1; % Whether to print the trial information to the command window.
    

% Path     
% ----
 dir = (which('expLauncher'));cd(dir(1:end-18));

% Add paths
% ---------------
addpath('Config','Main','Stim','Trial','Data','Conversion','Misc','GUI');
         
% Subject configuration     
% ---------------------
[const] = sbjConfig(const);
  
% Main run. Main is the function that runs all the config functions.
% ---------
main(const);