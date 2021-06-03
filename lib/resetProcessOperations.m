function resetProcessOperations()
% Reset global variable processOperations
% function resetProcessOperations()
%
% DESCRIPTION:
% Reset global variable processOperations

global processOperations

pathNeqSim();

if ~isempty(processOperations)
    processOperations.clearAll
end

if isempty(processOperations)
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end
