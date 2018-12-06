processOperations.clearAll
pressure = 100.0;
temperatureGuess = 10.0;  % cheched

% Defining system of components
system1 = neqsim.thermo.system.SystemSrkCPAstatoil(273.15+temperatureGuess, pressure);
system1.addComponent('methane',40.72); 
system1.addComponent('ethane',2.41);
system1.addComponent('propane',1.88);
system1.addComponent('i-butane',0.08)
system1.addComponent('n-butane', 0.12);
system1.addComponent('n-pentane', 1.64);
system1.addComponent('n-hexane', 3.29);
system1.addComponent('n-heptane', 8.22);
system1.addComponent('n-octane', 9.32);
!system1.addComponent('C9', 8.77);
!system1.addComponent('C10', 8.22);
!system1.addComponent('C11', 4.93);
!system1.addComponent('C12', 8.22);

%system1.addComponent('MEG', 30.0);
%system1.addComponent('methanol', 30.0);
system1.addComponent('ethanol', 3.0);
system1.addComponent('water', 100.0);

% Setting up calculation methods (multiphase) and mixing rule (temperature dependent kij)
system1.createDatabase(1);
system1.setMultiPhaseCheck(0);
system1.setMixingRule(9);    

% defining streams
inStream = stream(system1,'teststream');

% calculatiing hydrate temperature of stream
inStream.getHydrateEquilibriumTemperature;

% display system properties and hydrate equilibrium temperature
system1
system1.getTemperature-273.15