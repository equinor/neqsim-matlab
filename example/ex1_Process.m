processOperations.clearAll

system1 = neqsim.thermo.system.SystemSrkEos(273.15+30.0,30.0);
system1.addComponent('methane', 90.0);
system1.addComponent('ethane', 7.0);
system1.addComponent('propane', 3.0);
system1.addComponent('n-butane', 1.0);
system1.addComponent('i-butane', 1.0);
system1.addComponent('n-pentane', 1.0);
system1.addTBPfraction('C6', 1.49985, 86.3 / 1000.0, 0.7232);
system1.addTBPfraction('C7', 0.359864, 96.0 / 1000.0, 0.738);
system1.addTBPfraction('C8', 0.0939906, 107.0 / 1000.0, 0.765);
system1.addTBPfraction('C9', 0.0879912, 121.0 / 1000.0, 0.781);
system1.addTBPfraction('C10', 0.45, 134.0 / 1000.0, 0.792);
system1.addComponent('water', 1.0);        
system1.setMultiPhaseCheck(1);
system1.createDatabase(1);
system1.setMixingRule(2);    

stream1 = stream(system1,'troll1');
separator1 = separator(stream1,'inlet_separator');
compressor1 = compressor(separator1.getGasOutStream, 50.0, 'gas compressor');
cooler1 = heatexchanger(compressor1.getOutStream,288.15,'heater 1');

scrubber1 = gasscrubber(cooler1.getOutStream, 'scrubber1');
%scrubber1.setDiameter(1.0);
%scrubber1.addScrubberSection('VanePack1 50mm');
%scrubber1.addScrubberSection('MeshPad 50 mm');

stream2 = stream(scrubber1.getGasOutStream(),'gas from scrubber');

processOperations.run
processOperations.displayResult
