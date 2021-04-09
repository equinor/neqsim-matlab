% define thermodynamics
global system1
pathNeqSim();

system1 = neqsim.thermo.system.SystemSrkEos(323.15,70.00);
system1.addComponent('methane',1.0);
system1.addComponent('H2S',0.03);
system1.createDatabase(1);
system1.setMixingRule(2);
system1.init(0);
TPflash(system1);
f70 = system1.getPhase(0).getComponent('H2S').getFugasityCoefficient();

system1.addComponent('H2S',0.07);
system1.setPressure(20);

TPflash(system1);
f20 = system1.getPhase(0).getComponent('H2S').getFugasityCoefficient();


% c
system1.setTemperature(323.15);
system1.setPressure(70);
system1.reset()
system1.addComponent('methane',0.01);
system1.addComponent('H2S',0.01);

system1.init(1);
system1.getPhase(0).getComponent('H2S').getx()
system1.getPhase(0).getComponent('H2S').getFugasityCoefficient()