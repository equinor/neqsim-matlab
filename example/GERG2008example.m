fluid1 = thermo('srk',295.32, 250.0);
fluid1.addComponent('CO2', 2.01);
fluid1.addComponent('nitrogen', 1.01);
fluid1.addComponent('methane', 88.181);
fluid1.addComponent('ethane', 7.19);
fluid1.addComponent('propane', 0.599);
fluid1.addComponent('n-butane', 1.01);

TPflash(fluid1,0);

srkdensity = fluid1.getPhase('gas').getDensity('kg/m3')
GERG2008density = densityGERG2008(fluid1.getPhase('gas'))




