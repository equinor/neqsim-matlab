system1 = neqsim.thermo.system.SystemPrEos(310.93,108.00); 
system1.addComponent('methane', 0.736); %mole frac like feed
system1.addComponent('n-butane',0.264);
system1.createDatabase(1);
system1.setMixingRule(2); 
system1.useVolumeCorrection(0) %Default value is "1" - use volume correction

system1.getInterphaseProperties().setInterfacialTensionModel(1); 
system1.initPhysicalProperties();

TPflash(system1,0); %how to close the report

