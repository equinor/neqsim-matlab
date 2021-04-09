function testSystem = PHflash(testSystem,enthalpy,display)
pathNeqSim();

if nargin < 3
    display = true;
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.PHflash(enthalpy,0);
if display
    testFlash.displayResult;
end
clear testFlash;