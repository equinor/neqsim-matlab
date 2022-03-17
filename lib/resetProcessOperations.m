function resetProcessOperations()
% Reset global variable processOperations
% function resetProcessOperations()
%
% DESCRIPTION:
% Reset global variable processOperations

global processOperations

% This creates processOperations object if it does not already exist
pathNeqSim();

if ~isempty(processOperations)
    processOperations.clearAll();
end