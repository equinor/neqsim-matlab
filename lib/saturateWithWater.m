function p = saturateWithWater(testSystem)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.saturateWithWater();
p = testFlash.getPressure();
clear testFlash;