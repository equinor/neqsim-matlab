clear all;
test = neqsim.thermo.system.SystemSrkEos();
test.addComponent('methane',10.0);
test.addComponent('n-heptane',12.0);
test.addComponent('nC10',1.0);
test.setMixingRule(2);

i = 0;
for temperature = [270:2:590]
    i = i + 1;
    j = 0;
    temp(i) = temperature;
    for pressure = [1:2:300]
        j = j + 1;
        pres(j) = pressure;
        test.setTemperature(temperature)
        test.setPressure(pressure)
        TPflash(test,0);
        test.init(3);
        numberOfPhases(i,j) = test.getNumberOfPhases;
        enthalpy(i,j) = test.getEnthalpy;
        density(i,j) = test.getDensity;
        internalEnergy(i,j) = test.getInternalEnergy;
        molarVolume(i,j) = test.getMolarVolume;
    end
end