system1 = neqsim.thermo.system.SystemSrkEos(280,10);
system1.addComponent('methane',10.0);
system1.addComponent('water',10.0);
system1.setMixingRule(2);

system2 = neqsim.thermo.system.SystemSrkEos(280,10);
system2.addComponent('methane',22.0);
system2.addComponent('water',10.0);
system2.setMixingRule(2);

stream1 = stream(system1,'troll1');
stream2 = stream(system2,'troll2');

mixer1 = mixer('troll_mixer');
mixer1.addStream(stream1);
mixer1.addStream(stream2);

separator1 = separator(mixer1.getOutStream,'troll_separator');
valve1 = valve(separator1.getGasOutStream,1.0,'troll_valve');

processOperations.run
%processOperations.displayResult
valve1.displayResult