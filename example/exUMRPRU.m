fluid1 = thermo('UMR-PRU-EoS',300.0,50.0);
fluid1.addComponent('nitrogen',0.009006131);
fluid1.addComponent('CO2',0.024310934);
fluid1.addComponent('methane',0.826325051);
fluid1.addComponent('ethane',0.073200099);
fluid1.addComponent('propane',0.042319605);
fluid1.addComponent('i-butane',0.005935828);
fluid1.addComponent('n-butane',0.010718588);
fluid1.addComponent('22-dim-C3',0.00014061);
fluid1.addComponent('i-pentane',0.002230576);
fluid1.addComponent('n-pentane',0.002331);
fluid1.addComponent('c-C5',0.000135312);
fluid1.addComponent('22-dim-C4',3.45821E-05);
fluid1.addComponent('23-dim-C4',7.22516E-05);
fluid1.addComponent('2-m-C5',0.000456884);
fluid1.addComponent('3-m-C5',0.000241271);
fluid1.addComponent('n-hexane',0.000619165);
fluid1.addComponent('benzene',0.000146203);
fluid1.addComponent('c-hexane',0.000751127);
fluid1.addComponent('n-heptane',0.000388521);
fluid1.addComponent('toluene',0.000118175);
fluid1.addComponent('c-C7',0.000349257);
fluid1.addComponent('n-octane',8.61338E-05);
fluid1.addComponent('m-Xylene',2.56029E-05);
fluid1.addComponent('c-C8',2.47157E-05);
fluid1.addComponent('n-nonane',2.23129E-05);
fluid1.addComponent('nC10',9.84092E-06);
fluid1.addComponent('nC11',2.22E-07);

fluid1.createDatabase(1);
fluid1.setMixingRule('HV','UNIFAC_UMRPRU');

dewt(fluid1);

fluid1.getTemperature() - 273.15
fluid1