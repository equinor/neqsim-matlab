resetProcessOperations();

system1 = thermo('cpa',273.15+28.0,135.0);
system1.addComponent('CO2',2.251);
system1.addComponent('nitrogen',0.55);
system1.addComponent('methane',65.799);
system1.addComponent('ethane',13.238);
system1.addComponent('propane',12.588);
system1.addComponent('i-butane',1.691);
system1.addComponent('n-butane',3.172);
system1.addComponent('n-pentane',0.37);
system1.addComponent('water',1e-10);
system1.addComponent('methanol',1e-10);

system1.setMultiPhaseCheck(1);
system1.createDatabase(1);
system1.setMixingRule(9);
% todo: Failed to solve for molarVolume within the iteration limit.
saturateWithWater(system1);

inStream = stream(system1,'Åsgard stream');

system2 = thermo('cpa',273.15+28.0,135.0);
system2.addComponent('methanol',1.67*system1.getPhase(0).getComponent('water').getNumberOfmoles());
system2.setMultiPhaseCheck(1);
system2.createDatabase(1);
system2.setMixingRule(9);
MeOHstream = stream(system2);

HPmixer = mixer('HP mixer');
HPmixer.addStream(inStream);
HPmixer.addStream(MeOHstream);

choke = valve(HPmixer.getOutStream,132.0,'calc stream');
outstream = choke.getOutStream;

runProcess();

outstream.getHydrateEquilibriumTemperature();
%outstream.displayResult