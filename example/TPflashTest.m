pathNeqSim();

testSystem = neqsim.thermo.system.SystemSrkEos(290,10);
testSystem.addComponent('methane',1);
testSystem.createDatabase(1);

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.TPflash;
clear testFlash;