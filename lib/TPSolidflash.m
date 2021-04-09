function testSystem = TPSolidflash(testSystem)
pathNeqSim();

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.TPSolidflash;
end