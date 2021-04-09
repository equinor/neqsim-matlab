pathNeqSim();

test = neqsim.thermo.system.SystemSrkEos(280,10);
test.addComponent('methane',10.0);
test.addComponent('water',10.0);
test.createDatabase(1);
test.setMixingRule(2)
TPflash(test,0);

entalpi = enthalpy(test);
energi = energy(test);
beta = Z(test)
dvisk = dynvisc(test)
gibbse = gibbsenergy(test)
helmhe = helmholtzenergy(test)
M = molarmass(test)
entr = entropy(test)
kinvisk = kinvisc(test)
totmoles = moles(test)
frac1 = molefrac(test,1)
conduc = conductivity(test)