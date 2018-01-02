function EventTable = GenerateEventTable(conds, repetitions, isfixed)

% function GenerateEventTable(conds, repetitions, isfixed)
%
% reads text file and displays it to the console
%
% INPUT : conds = vector containing factors/number
% : repetitions = number of repetitions
% : isfixed = 0: random order 1: fixed order
% OUTPUT: EventTable = is a vector of struct
%
% Author: Borgo, Soranzo, Grassi 2010

EventTable = [];
for i=1:repetitions
    EventTable = [EventTable; shoveonend(conds,i)];
end

TotalNumberOfTrials = length(EventTable(:, 1));
if isfixed == 1
    FixedTrialSequence = (1:TotalNumberOfTrials)';
    EventTable = [FixedTrialSequence, EventTable];
    
else
    RandomTrialSequence = randperm(TotalNumberOfTrials)';
    EventTable = [RandomTrialSequence, EventTable];
    EventTable = sortrows(EventTable, 1);
end

