function runProcess()
% Run Process operation simulation
% function runProcess()
%
% DESCRIPTION:
% Run processOperations simulation

global processOperations

if isempty(processOperations)
    processOperations = neqsim.processsimulation.processsystem.ProcessSystem();
end

processOperations.run();
