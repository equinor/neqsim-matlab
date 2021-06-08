function runProcess()
% Run Process operation simulation
% function runProcess()
%
% DESCRIPTION:
% Run processOperations simulation

global processOperations

if isempty(processOperations)
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem();
end

processOperations.run();
