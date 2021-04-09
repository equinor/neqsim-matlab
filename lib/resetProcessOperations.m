function resetProcessOperations()
%
% function resetProcessOperations()
%
% DESCRIPTION:
% Wrapper for

global processOperations

pathNeqSim();

if ~isempty(processOperations)
    processOperations.clearAll
end

if isempty(processOperations)
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end