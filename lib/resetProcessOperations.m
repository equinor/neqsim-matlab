function resetProcessOperations()
%
% function resetProcessOperations()
%
% DESCRIPTION:
% Wrapper for

global processOperations

if ~isempty(processOperations)
    processOperations.clearAll
end

if isempty(processOperations)
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end