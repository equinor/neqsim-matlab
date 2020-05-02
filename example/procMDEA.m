global processOperations

resetProcessOperations();
processOperations.clearAll


system1 = neqsim.thermo.system.SystemSrkCPAstatoil(273.15+45.0,66.0);
system1.addComponent('methane',5.0);
system1.addComponent('MDEA',0.1);
system1.addComponent('water',0.9);

system1.setMultiPhaseCheck(1);
system1.createDatabase(1);
system1.setMixingRule(9);

wellStream = stream(system1,'Absorber saturator');
inletSeparator = separator(wellStream,'separator');

LP1heater = heatexchanger(inletSeparator.getGasOutStream,273.15+26.0,'cooler');
LP1separator = separator(LP1heater.getOutStream,'wash tower');

processOperations.run

wtppm = LP1separator.getThermoSystem().getPhase(1).getComponent('MDEA').getx()*LP1separator.getThermoSystem().getPhase(1).getComponent('MDEA').getMolarMass()/LP1separator.getThermoSystem().getPhase(1).getMolarMass()*1e6
LP1separator.getThermoSystem().getPhase(1).getActivityCoefficient(2)
processOperations.displayResult