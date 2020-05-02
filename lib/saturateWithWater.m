function p = saturateWithWater(testSystem)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.saturateWithWater();
clear testFlash;