resetProcessOperations()

system1 = neqsim.thermo.system.SystemSrkCPAstatoil(273.15+70.0,150.0);
system1.addComponent('methane',75.0);
system1.addComponent('ethane',7.5);
system1.addComponent('propane',4.0);
system1.addComponent('n-butane',1.0);
system1.addComponent('i-butane',0.6);
system1.addComponent('n-hexane',0.3);
system1.addPlusFraction('C6',1.3,100.3/1000.0,0.8232);
system1.addComponent('water',1e-10);
system1.addComponent('TEG',1e-10);

system1.createDatabase(1);
system1.setMixingRule(9);
system1.setMultiPhaseCheck(1);
saturateWithWater(system1);

wellStream = stream(system1,'Åsgard well stream');

choke = valve(wellStream,80.0,'top side choke');
seaCooler = heatexchanger(choke.getOutStream,303.15,'sea cooler');
inletSeparator = separator(seaCooler.getOutStream,'inlet_separator');

% condensate separation system
LP1choke = valve(inletSeparator.getOilOutStream,15.0,'LP1 choke');
LP1heater = heatexchanger(LP1choke.getOutStream,298.15,'LP1 heater');
LP1separator = separator(LP1heater.getOutStream,'LP1separator');

LP2choke = valve(LP1separator.getOilOutStream,1.0,'LP2 choke');
LP2heater = heatexchanger(LP2choke.getOutStream,298.15,'LP2 heater');
LP2separator = separator(LP2heater.getOutStream,'LP2separator');
condensateProduct = LP2separator.getOilOutStream;
LP2recompressor = compressor(LP2separator.getGasOutStream,15.0,'LP2 compressor');

MPmixer = mixer('HP mixer');
MPmixer.addStream(LP1separator.getGasOutStream);
MPmixer.addStream(LP2recompressor.getOutStream);

LP1recompressor = compressor(MPmixer.getOutStream,80.0,'LP1 compressor');
LP1cooler = heatexchanger(LP1recompressor.getOutStream,288.15,'LP1 cooler');
LP1scrubber = gasscrubber(LP1cooler.getOutStream,'scrubber - LP1');
%LP1scrubber.addScrubberSection('MeshPad 50 mm');

% gas process
HPmixer = mixer('HP mixer');
HPmixer.addStream(inletSeparator.getGasOutStream);
HPmixer.addStream(LP1scrubber.getGasOutStream);

gasProductCooler = heatexchanger(HPmixer.getOutStream);
gasProductCooler.setdT(-5.0);
gasProductCooler.setName('Gas Product Cooler');

gasProductScrubber = gasscrubber(gasProductCooler.getOutStream,'scrubber - gas from inlet separator');
%gasProductScrubber.addScrubberSection('MeshPad 50 mm');
MPmixer.addStream(gasProductScrubber.getLiquidOutStream);

gasProductHeater = heatexchanger(gasProductScrubber.getGasOutStream);
gasProductHeater.setdT(5.0);
gasProductHeater.setName('Gas Product Heater');
%gasProductStream = gasProductScrubber.getGasOutStream()

system2 = neqsim.thermo.system.SystemSrkCPAstatoil(273.15+25.0,80.0);
system2.addComponent('methane',1.0e-6);
system2.addComponent('water',1.0e-4);
system2.addComponent('TEG',4.0);
system2.setMultiPhaseCheck(1);
system2.createDatabase(1);
system2.setMixingRule(7);
TEGstream = stream(system2);

TEGabsorber = absorber('TEGAbsorber');
TEGabsorber.addGasInStream(gasProductHeater.getOutStream);
TEGabsorber.addSolventInStream(TEGstream);
TEGabsorber.setNumberOfStages(5);
TEGabsorber.setStageEfficiency(0.5);
TEGabsorber.setWaterDewPointTemperature(253.15,70.0);

gasProductCooler2 = heatexchanger(TEGabsorber.getGasOutStream);
gasProductCooler2.setdT(-5.0);
gasProductCooler2.setName('Gas Product Cooler2');
gasProductScrubber2 = gasscrubber(gasProductCooler2.getOutStream,'scrubber - gas scrubber');
%gasProductScrubber2.addScrubberSection('MeshPad 50 mm');
%gasProductScrubber2.getScrubberSection(0).setEfficiency(1.0);

HP1recompressor = compressor(gasProductScrubber2.getGasOutStream,200.0,'HP compressor');
HP1cooler = heatexchanger(HP1recompressor.getOutStream,288.15,'HP cooler');

% Åsgard pipeline
choke2 = valve(HP1cooler.getOutStream,110.0,'Kårstø choke');
seaCooler2 = heatexchanger(choke2.getOutStream,278.15,'sea cooler');
inletSeparator2 = separator(seaCooler2.getOutStream(),'Kårstø inlet_separator');

processOperations.run
processOperations.run
processOperations.run

condensateProduct.displayResult
HP1cooler.displayResult
inletSeparator2.displayResult
%processOperations.displayResult

%wellStream.getHydrateEquilibriumTemperature
%wellStream.displayResult