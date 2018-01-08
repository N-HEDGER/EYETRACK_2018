function [Trialevents]=designConfig(const)
% ----------------------------------------------------------------------
% [const]=designConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Create trialevents and store in matrix;
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% Trialevents: struct containing trialevents
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project :     Eyetracking 2018
% Version :     1.0
% ----------------------------------------------------------------------

% Define all possible combnations of the variables with 2 levels
% (Left or right?, scram)


trialmat = unique(nchoosek([1,2,1,2],2), 'rows');

% Socleft intact
% Socleft scrambled
% Socright intact
% Socright scrambled

% Now add durations
Table = [];
for i=1:length(const.durations)
Table=[Table; shoveonend(trialmat,const.durations(i))];
end
                    
Trialevents.trialmat=GenerateEventTable(Table,const.reps,const.isfixed);