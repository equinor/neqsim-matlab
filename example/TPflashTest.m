function testSystem = TPflashTest()
testSystem = neqsim.thermo.system.SystemSrkEos(290,10);
testSystem.addComponent('methane',1);
testSystem.createDatabase(1);

if nargin == 1
    display = 1
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.TPflash;
clear testFlash;
testSystem