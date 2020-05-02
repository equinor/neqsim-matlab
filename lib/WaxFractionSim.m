function testSystem = TPflash(testSystem,display)
if nargin == 1
    display = 1
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.TPflash;
if display == 1
    testFlash.displayResult;
end
clear testFlash;
testSystem;