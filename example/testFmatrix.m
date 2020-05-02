fluid1 = thermo('srk',150.0,10.0);
fluid1.addComponent('CO2',0.024310934);
fluid1.addComponent('methane',0.826325051);
fluid1.addComponent('ethane',0.073200099);
fluid1.addComponent('propane',0.042319605);
fluid1.addComponent('i-butane',0.005935828);
fluid1.addComponent('n-butane',0.010718588);


fluid1.createDatabase(1);
fluid1.setMixingRule(2);

%TPflash(fluid1,0);
fluid1.init(0);
fluid1.init(3);

dFdxMatrix = fluid1.getPhase(0).dFdxMatrix()
dFdxdxMatrix = fluid1.getPhase(0).dFdxdxMatrix()