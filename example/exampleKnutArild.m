% Maureen Mariner Composition
system1 = neqsim.thermo.system.SystemSrkEos(309,280);
system1.getCharacterization().setTBPModel('PedersenSRK');
system1.addComponent('nitrogen',0.36);
system1.addComponent('CO2',0.4);
system1.addComponent('methane',35.07);
system1.addComponent('ethane',0.17);
system1.addComponent('propane',0.06);
system1.addComponent('i-butane',0.04);
system1.addTBPfraction('C7',0.03,90.645/1000.0,0.7709);
system1.addTBPfraction('C8',0.02,103.418/1000.0,0.798);
system1.addTBPfraction('C9',0.18,115.361/1000.0,0.8168);
system1.addTBPfraction('C10)',0.46,127.087/1000.0,0.8317);
system1.addTBPfraction('C11',4.85,152.969/1000.0,0.8575);
system1.addTBPfraction('C12',19.17,200.781/1000.0,0.8911);
system1.addTBPfraction('C13',8.36,256.61/1000.0,0.9189);
system1.addTBPfraction('C14',6.42,306.011/1000.0,0.9381);
system1.addTBPfraction('C15',24.41,653.609/1000.0,1.10187);

%system1.setHeavyTBPfractionAsPlusFraction();
%system1.getCharacterization().characterisePlusFraction();

system1.createDatabase(1);
system1.setMixingRule(2);
system1.setMultiPhaseCheck(1);
%system1.initPhysicalProperties();
TPflash(system1,1);
bubp(system1);
%system1.saveFluid(37);
% BubP = thermodynamicOperations.flashOps.saturationOps.bubblePointPressureFlashDer(system1);
% BubP.run();
%
% bubpPres = BubP.getThermoSystem().getPressure();
%
% B = bubpPres;
% B
%              BubP = PVTsimulation.simulation.SaturationPressure(system1);
%              BubP.run();
%              bubpPres = BubP.getThermoSystem().getPressure();

%              B = bubpPres;
%B