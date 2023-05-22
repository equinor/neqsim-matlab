fluid1 = thermo('srk');
fluid1.addComponent('methane', 90.0);
fluid1.addComponent('ethane', 10.0);
fluid1.setMixingRule(2);


fluid1.setTemperature(20.0, 'C');
fluid1.setPressure(100.0, 'bara');
TPflash(fluid1);
fluid1.initPhysicalProperties();

visc = fluid1.getPhase('gas').getViscosity('kg/msec');
