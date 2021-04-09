function testSystem = PSflash(testSystem,entropy,display)
pathNeqSim();

if nargin < 3
    display = true;
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.PSflash(entropy);
if display
    testFlash.displayResult;
end
clear testFlash;