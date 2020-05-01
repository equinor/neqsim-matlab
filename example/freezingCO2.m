system1 = thermo('srk',250.0,20.0); %  EoS / Temperature [Kelvin] / Pressure [bara]
system1.addComponent('methane',90.0);
system1.addComponent('ethane',5.0);
system1.addComponent('propane',5.0);
system1.addComponent('CO2',10.0);
system1.setMixingRule('classic');
system1.setSolidPhaseCheck('CO2');
freezt(system1);
system1
disp(['freezing temperature ',num2str(system1.getTemperature() - 273.15)])