pathNeqSim();

system1 = neqsim.thermo.system.SystemPrEos(240.93,30.00);
system1.addComponent('methane',0.736); %mole frac like feed
system1.addComponent('n-butane',0.464);
system1.createDatabase(1);
system1.setMixingRule(2);
system1.useVolumeCorrection(0) %Default value is "1" - use volume correction

system1.getInterphaseProperties().setInterfacialTensionModel(0);


TPflash(system1,0);

system1.initPhysicalProperties();

% todo: this fails
system1.getInterphaseProperties().getSurfaceTension(0);

temperature = (-195 + 273.15):1.54:(200)
pressure = 1:5:400

for n = 1:80
    system1.setTemperature(temperature(n));
    for k = 1:80
        system1.setPressure(pressure(k));
        TPflash(system1,0);
        system1.initPhysicalProperties();
        interf(n,k) = system1.getInterphaseProperties().getSurfaceTension(0);
    end
end