test = thermo('cpa',150.0, 1.0);
test.addComponent('methane', 10.0);
test.addComponent('propane', 1.0);
test.addComponent('n-pentane', 1.0);
test.addComponent('water', 1.0);
test.createDatabase(1);
test.setMixingRule(10);
test.setMultiPhaseCheck(1)
% test.getInterphaseProperties().setInterfacialTensionModel(0); % 1 gradient theory, 2 LGT, 3 Parachor

TPflash(test,0);
test

