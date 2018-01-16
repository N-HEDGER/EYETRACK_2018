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


%trialmat = unique(nchoosek([1,2,1,2],2), 'rows');

% Socleft intact
% Socleft scrambled
% Socright intact
% Socright scrambled

% Now add durations
%Table = [];
%for i=1:length(const.durations)
%Table=[Table; shoveonend(trialmat,const.durations(i))];
%end
                    
%Trialevents.trialmat=GenerateEventTable(Table,const.reps,const.isfixed);


rng(1)
vec=1:const.reps;
modvec=vec(randperm(length(vec)))';
sidevec=repmat([1;2],const.reps/2,1);
fullvecin=horzcat(sidevec,repmat(1,const.reps,1),repmat(const.durations(1),const.reps,1),modvec);
fullvecsc=horzcat(sidevec,repmat(2,const.reps,1),repmat(const.durations(1),const.reps,1),modvec);


fullvec=vertcat(fullvecin,fullvecsc);
     
Trialevents.trialmat=GenerateEventTable(fullvec,1,const.isfixed);
