resetProcessOperations();

pressure = 50.0;
temperatureGuess = 10.0; % to check

% Defining system of components
system1 = thermo('cpa',273.15+temperatureGuess,pressure);
% system1.addComponent('methane',75);
% system1.addComponent('ethane',17);
% system1.addComponent('propane',8);
system1.addComponent('methane',40.72);
system1.addComponent('ethane',2.41);
system1.addComponent('propane',1.88);
system1.addComponent('i-butane',0.08);
system1.addComponent('n-butane',0.12);
system1.addComponent('n-pentane',1.64);
%system1.addComponent('n-hexane', 3.29);
system1.addTBPfraction('C6',3.29,86.178/1000.0,0.6640);
system1.addTBPfraction('C7',8.22,96.0/1000.0,0.7380);
system1.addTBPfraction('C8',9.32,107.0/1000.0,0.7650);
system1.addTBPfraction('C9',8.77,121.0/1000.0,0.7810);
system1.addTBPfraction('C10',8.22,134.0/1000.0,0.7920);
system1.addTBPfraction('C11',4.93,147.0/1000.0,0.7960);
system1.addTBPfraction('C12',3.84,161.0/1000.0,0.8100);
system1.addTBPfraction('C13',2.74,175.0/1000.0,0.8250);
system1.addTBPfraction('C14',2.19,190.0/1000.0,0.8360);
system1.addTBPfraction('C15',1.64,206.0/1000.0,0.8420);

%system1.addComponent('NaCl', 1.0);

%system1.addComponent('methanol', 32.77153558);
system1.addComponent('water',0.001);
system1.addComponent('MEG',0.0003);
%system1.addComponent('ethanol', 0.837235263);
% Setting up calculation methods (multiphase) and mixing rule (temperature dependent kij)
system1.createDatabase(1);
system1.setMixingRule(9);
system1.setHydrateCheck(1);
system1.setMultiPhaseCheck(1);

hydt(system1);
%TPflash(system1);
% defining streams
%inStream = stream(system1,'teststream');
%processOperations.run();
% calculatiing hydrate temperature of stream
%inStream.getHydrateEquilibriumTemperature;

% display system properties and hydrate equilibrium temperature
%system1
system1.getTemperature - 273.15