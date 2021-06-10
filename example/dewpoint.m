system1 = neqsim.thermo.system.SystemSrkEos(310.95,60.0);
system1.addComponent('methane',0.8);
system1.addComponent('n-butane',0.5);
system1.createDatabase(1);
system1.setMixingRule(2);
system1.setBmixType(1);

dewt(system1)