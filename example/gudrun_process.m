global processOperations
resetProcessOperations();

% setting up feed fluid and thermodynamic model
system1 = neqsim.thermo.system.SystemSrkCPAstatoil(273.15+16.0, 50.0);
system1.addComponent('CO2',0.0448);
system1.addComponent('nitrogen',0.005);
system1.addComponent('methane',0.7791);
system1.addComponent('ethane', 0.0902);
system1.addComponent('propane', 0.0516);
system1.addComponent('i-butane', 0.006);
system1.addComponent('n-butane', 0.0131);
system1.addComponent('i-pentane', 0.0027);
system1.addComponent('n-pentane', 0.005);
system1.addComponent('n-heptane', 0.0031);
system1.addComponent('water',8.1e-4);
system1.addComponent('MEG', 1.57e-4);
system1.createDatabase(1);
system1.setMixingRule(9);   
system1.setMultiPhaseCheck(1);

% setting pressure and temperature of inlet fluid
system1.setTemperature(273.15+16.0);
system1.setPressure(36.0);


% setting up process
wellStream = stream(system1,'Gudrun inlet stream');
inletSeparator = separator(wellStream,'inlet_separator');
condensateValve = valve(inletSeparator.getOilOutStream, 11.0, 'condensate valve');

% running process simulation
processOperations.run

% display composition of the processunits
processOperations.displayResult


% calculating hydrate equilibrium temperatures for gas and condesate
gasHydrateTemperature = inletSeparator.getGasOutStream().getSolidFormationTemperature('hydrate');
oilHydrateTemperature = condensateValve.getOutStream().getSolidFormationTemperature('hydrate');

