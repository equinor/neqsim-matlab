system1 = neqsim.thermo.system.SystemSrkEos(273,10);
%system1.addComponent('methane', 10.0);
%system1.addComponent('ethane', 10.0);
system1.addComponent('propane', 0.355);
system1.addComponent('i-butane', 0.448);
system1.addComponent('n-butane', 0.23664);
system1.addComponent('i-pentane', 2.031);
system1.addComponent('n-pentane', 3.457);

 


system1.addTBPfraction('C7', 5.0, 234.0/1000.0, 0.85);


%Characterise plussfraction
system1.setHeavyTBPfractionAsPlusFraction();
system1.getCharacterization().getLumpingModel().setNumberOfLumpedComponents(12)
system1.getCharacterization().characterisePlusFraction();

%system1.getWaxModel().setWaxParameters(newParams);
%%%%%%%%%%%%%%%%%%%

system1.getWaxModel().addTBPWax();
system1.createDatabase(1);

system1.addSolidComplexPhase('wax');
system1.setMultiphaseWaxCheck(1);

system1.setMultiPhaseCheck(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


system1.setTemperature(280.0);
system1.setPressure(5.0);
TPflash(system1,1);

%calcWAT(system1);
system1.getTemperature;
waxfraction=system1.getPhase('oil').getWtFractionOfWaxFormingComponents();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%wtfracWax = system1.getPhase('wax').getNumberOfMolesInPhase()*system1.getPhase('wax').getMolarMass()/(system1.getMolarMass()*system1.getNumberOfMoles());
wtfracWax = system1.getWtFraction(system1.getPhaseNumberOfPhase('wax'));

temperatures = [280.0,270.0,265.0,260.0];
pressures = [5.0,5.0,5.0, 5.0];
expdata = [7.0,9.0,10.0,11.0;0,0,0,0];

optim = WaxFractionSim(system1);
optim.setTemperaturesAndPressures(temperatures, pressures);
optim.setExperimentalData(expdata);

optim.runTuning();
newParams = system1.getWaxModel().getWaxParameters();

system1.getWaxModel().setWaxParameters(newParams);
optim.runCalc();
optimFractions = optim.getWaxFraction();
optimFractions

system1.setTemperature(260.0);
TPflash(system1);
wtfracWax1 = system1.getPhase('wax').getNumberOfMolesInPhase()*system1.getPhase('wax').getMolarMass()/(system1.getMolarMass()*system1.getNumberOfMoles());
wtfracWax2 = system1.getWtFraction(system1.getPhaseNumberOfPhase('wax'));