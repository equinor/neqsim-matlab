
test = thermo('PSRK-EoS',255.32, 6);
test.addComponent('methane', 0.01);
test.addComponent('H2S', 0.99);
test.createDatabase(1);
test.setMixingRule('HV', 'UNIFAC_PSRK');

%TPflash(test,0);
%bubp(test);
dewp(test);
%temper = test.getTemperature - 273.15
test

