testSystem = SystemSrk (290.15, 10.00);
testOps = ThermodynamicOperations(testSystem);
testSystem.addComponent("methane", 50);
testSystem.addComponent("water", 50);
testSystem.setMixingRule(4);
testOps.TPflash();
testOps.displayResult();