function testSystem = TPSolidflash(testSystem)
if nargin == 1
    display = 1
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.TPSolidflash;
end