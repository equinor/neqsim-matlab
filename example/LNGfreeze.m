system1 = neqsim.thermo.system.SystemSrkEos(100,50.0); %  Kelvin / bara
system1.addComponent('methane',90.0); %mole frac like feed
%system1.addComponent('ethane', 0.0.000293);
%system1.addComponent('propane', 0.01);
system1.addComponent('CO2',10.0);
%system1.createDatabase(1);
system1.setMixingRule(2); % 2 - klassisk blandingsregel

system1.setSolidPhaseCheck('CO2');
system1.init(0);
%TPflash(system1,0);
%freezt(system1)
startT = 180
operation = neqsim.thermodynamicOperations.flashOps.saturationOps.freezingPointTemperatureFlash(system1);

for i = 1:800
    system1.setTemperature(startT+i/20)
    temp(i) = system1.getTemperature();
    temp(i)
    func(i) = operation.calcFunc()*10;
    phases(i) = system1.getNumberOfPhases();
end
