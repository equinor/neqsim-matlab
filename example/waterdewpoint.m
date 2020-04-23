resetProcessOperations();

pressure = 70.0;
temperatureGuess = -50.0;  % cheched

% Defining system of components
system1 = neqsim.thermo.system.SystemSrkCPAstatoil(273.15+temperatureGuess, pressure);
system1.addComponent('methane',0.94); 
system1.addComponent('ethane', 0.05); 
system1.addComponent('propane', 0.01);
system1.addComponent('CO2', 0.01); 
system1.addComponent('water', 1.0e-12);

% Setting up calculation methods (multiphase) and mixing rule (temperature dependent kij)
system1.createDatabase(1);
system1.setMixingRule(9);

% defining streams
inStream = stream(system1,'teststream');

temperature = [];
ppmwater = [];
for i = 1:15
    system1.addComponent('water', 10e-6);
    %inStream.getSolidFormationTemperature('hydrate'); %use names hydrate or water
    dewt(system1); %use this function to calculate liquid water dewpoint
    temperature(i) = system1.getTemperature()-273.15;
    ppmwater(i) = system1.getPhase(0).getComponent('water').getx()*1e6
end
 
plot(temperature, ppmwater);