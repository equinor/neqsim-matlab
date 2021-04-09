function testSystem = TPflash(testSystem,display)
pathNeqSim();

if nargin < 2
    display = false;
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.TPflash;
if display
    testFlash.displayResult;
end
clear testFlash;