test = thermo('pr',280,10);
test.addComponent('methane',10.0);
test.addComponent('water',10.0);
test.createDatabase(1);
test.setMixingRule(2)

TPflash(test,1) % 1- display results 0 - not display results