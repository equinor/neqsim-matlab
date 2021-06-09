pathNeqSim();

testSystem = neqsim.thermo.system.SystemSrkEos(290,10);
testSystem.addComponent('methane',1);
testSystem.createDatabase(1);

TPflash(testSystem,true);