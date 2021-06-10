%calculate the interfacial tension of methane + n-butane at310.95K and
%108 Bar

pathNeqSim();

system1 = neqsim.thermo.system.SystemPrEos(310.93,108.00);
system1.addComponent('methane',0.736); %mole frac like feed
system1.addComponent('n-butane',0.264);
system1.createDatabase(1);
system1.setMixingRule(2);
system1.getInterphaseProperties().setInterfacialTensionModel('gas', 'oil', 'Linear Gradient Theory');
TPflash(system1,0); %how to close the report
system1.initProperties();
