fluid1 = thermo('UMR-PRU-EoS',273.15+55,25.0);
fluid1.addComponent('ethane',26.0);
fluid1.addComponent('n-hexane',44.5);
fluid1.createDatabase(1);
fluid1.setMixingRule('UNIFAC_UMRPRU');

%fluid1 = readFluid(2044);
%TPflash(fluid1);
PTenvelope(fluid1);
fluid1