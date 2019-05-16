system1 = thermo('srk', 203.2, 18.34); %  EoS / Temperature [Kelvin] / Pressure [bara]
system1.addComponent("nitrogen", 0.379);
system1.addComponent("CO2", 100.0);
system1.addComponent("methane", 85.299);
system1.addComponent("ethane", 7.359);
system1.addComponent("propane", 3.1);
system1.addComponent("i-butane", 0.504);
system1.addComponent("n-butane", 0.85);
system1.addComponent("i-pentane", 0.323);
system1.addComponent("n-pentane", 0.231);
system1.addComponent("n-hexane", 0.173);
system1.addComponent("n-heptane", 0.078);
system1.setMixingRule('classic')
system1.setSolidPhaseCheck('CO2');
TPflash(system1);
system1