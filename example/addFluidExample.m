system1 = neqsim.thermo.system.SystemSrkEos(280,10);
system1.addComponent('methane',10.0);
system1.addComponent('water',10.0);
system1.setMixingRule(2);
system1.setMultiPhaseCheck(1)

system2 = neqsim.thermo.system.SystemSrkEos(280,10);
system2.addComponent('n-butane',10.0);
system2.addComponent('water',10.0);
system2.setMixingRule(2);

system3 = addfluids(system1,system2);

TPflash(system3,1)