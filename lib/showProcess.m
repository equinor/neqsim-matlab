function showProcess()
% Show Process operation simulation result
% function showProcess()
%
% DESCRIPTION:
% Show Process operation simulation result

global processOperations

if isempty(processOperations)
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem();
end

show(processOperations);
