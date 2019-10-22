fluid1 = thermo('srk',295.32, 100.0);
fluid1.addComponent('CO2', 2.01);
fluid1.addComponent('nitrogen', 1.01);
fluid1.addComponent('methane', 88.181);
fluid1.addComponent('ethane', 7.19);
fluid1.addComponent('propane', 0.599);
fluid1.addComponent('n-butane', 1.01);
fluid1.addComponent('i-pentane', 1.01);
fluid1.addComponent('n-pentane', 0.01);
fluid1.addComponent('n-hexane', 0.01);
fluid1.setMixingRule('classic')
TPflash(fluid1,1);

srkdensity = fluid1.getPhase('gas').getDensity('kg/m3')
GERG2008density = densityGERG2008(fluid1.getPhase('gas'))

GERG2008 = neqsim.thermo.util.GERG.NeqSimGERG2008();
GERG2008density2 = GERG2008.getDensity(fluid1.getPhase('gas'))



