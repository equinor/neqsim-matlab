system1 = neqsim.thermo.system.SystemSrkEos(280.0,10.0);
system1.addComponent('methane',10.0);
system1.addComponent('n-heptane',10.0);
system1.createDatabase(1);
system1.setMixingRule(2);

TPflash(system1)

% adding 10 moles of methane to the gas phase
system1.addComponent('methane',10.0,0);
system1.init_x_y();
system1.initBeta();

% calculating all thermodynamic properties of the modified system
system1.init(3);

%displaying thermodynamic properties  0 is gas phase, 1 is liquid phase
disp 'molar volume ', system1.getPhase(0).getMolarVolume()
disp 'molar mass ', system1.getPhase(0).getMolarMass()
disp 'number of moles in phase ', system1.getPhase(0).getNumberOfMolesInPhase()

% displaying derivatives of the reduced helhlts energy F=(A/RT) as i Michelsens book
disp 'dFDV ', system1.getPhase(1).dFdV()
disp 'dFDVdV ', system1.getPhase(1).dFdVdV()
disp 'dFdTDV ', system1.getPhase(1).dFdTdV();

% calulating derivatives with respect to composition of the phase
disp 'dFdN', system1.getPhase(1).getComponent('methane').dFdN(system1.getPhase(1), system1.getPhase(0).getNumberOfComponents(), system1.getTemperature(), system1.getPressure())
disp 'dFdNdV', system1.getPhase(1).getComponent('methane').dFdNdV(system1.getPhase(1), system1.getPhase(0).getNumberOfComponents(), system1.getTemperature(), system1.getPressure())
disp 'dFdNdT', system1.getPhase(1).getComponent('methane').dFdNdT(system1.getPhase(1), system1.getPhase(0).getNumberOfComponents(), system1.getTemperature(), system1.getPressure())
disp 'dFdNddN', system1.getPhase(1).getComponent('methane').dFdNdN(0, system1.getPhase(1), system1.getPhase(0).getNumberOfComponents(), system1.getTemperature(), system1.getPressure())