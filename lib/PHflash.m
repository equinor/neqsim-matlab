function testSystem = PHflash(testSystem,enthalpy,display)
if nargin == 2
    display = 1
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.PHflash(enthalpy,0);
if display == 1
    testFlash.displayResult;
end
clear testFlash;
testSystem;