system1 = neqsim.thermo.system.SystemGERGwaterEos(298.15,50.00);
system1.addComponent('methane',0.5);
system1.addComponent('water',0.5);
system1.createDatabase(1);
system1.setMixingRule(8);

TPflash(system1);