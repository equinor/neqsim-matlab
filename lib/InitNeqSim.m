global processOperations

if isempty(processOperations) % added Even 10/12/2011
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end