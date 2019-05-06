fluid1 = thermo('umr',273.15+55, 25.0);
fluid1.addComponent('nitrogen', 2.4526);
fluid1.addComponent('CO2', 1.6318);
fluid1.addComponent('methane', 5.221);
fluid1.addComponent('ethane', 7.4681);
fluid1.addComponent('propane', 7.2278);
fluid1.addComponent('i-butane', 1.9121);
fluid1.addComponent('n-butane', 2.7229);
fluid1.addComponent('i-pentane', 0.7408);
fluid1.addComponent('n-pentane', 0.4405);
fluid1.addComponent('n-hexane', 0.1702);

fluid1.createDatabase(1);

fluid1.setMixingRule('HV', 'UNIFAC_UMRPRU');

dewt(fluid1); ! calculating dew point
fluid1.getTemperature() - 273.15

PTenvelope(fluid1); ! calculating phase envelope