pathNeqSim();

system1 = neqsim.thermo.system.SystemSrkEos(280.0,10.0);
system1.addComponent('methane',10.0);
system1.addComponent('n-heptane',10.0);
system1.createDatabase(1);
system1.setMixingRule(2);

TPflash(system1)

%displaying thermodynamic properties  0 is gas phase, 1 is liquid phase
disp 'molar volume ', system1.getPhase(0).getMolarVolume()
disp 'molar mass ', system1.getPhase(0).getMolarMass()
disp 'number of moles in phase ', system1.getPhase(0).getNumberOfMolesInPhase()

% displaying derivatives of the phase
disp 'dPdV ', system1.getPhase(0).getdPdTVn()

% displaying derivatives of the phase
disp 'dPdV ', system1.getPhase(0).getComponent(0).getChemicalPotential(system1.getPhase(0))

% displaying derivatives of the phase
disp 'dchempotdN(0) ', system1.getPhase(0).getComponent(0).getChemicalPotentialdN(0, system1.getPhase(0))
disp 'dchempotdN(1) ', system1.getPhase(0).getComponent(0).getChemicalPotentialdN(1, system1.getPhase(0))
disp 'dchempotdV ', system1.getPhase(0).getComponent(0).getChemicalPotentialdV(system1.getPhase(0))
disp 'Zc ', system1.getPhase(0).getComponent(0).getCriticalCompressibilityFactor()

% displaying derivatives of the reduced helhlts energy F=(A/RT) as i Michelsens book
disp 'dFDV ', system1.getPhase(1).dFdV()
disp 'dFDVdV ', system1.getPhase(1).dFdVdV()
disp 'dFdTDV ', system1.getPhase(1).dFdTdV()

% calulating derivatives with respect to composition of the phase
disp 'dFdN', system1.getPhase(1).getComponent('methane').dFdN(system1.getPhase(1), system1.getPhase(0).getNumberOfComponents(), system1.getTemperature(), system1.getPressure())
disp 'dFdNdV', system1.getPhase(1).getComponent('methane').dFdNdV(system1.getPhase(1), system1.getPhase(0).getNumberOfComponents(), system1.getTemperature(), system1.getPressure())
disp 'dFdNdT', system1.getPhase(1).getComponent('methane').dFdNdT(system1.getPhase(1), system1.getPhase(0).getNumberOfComponents(), system1.getTemperature(), system1.getPressure())
disp 'dFdNddN', system1.getPhase(1).getComponent('methane').dFdNdN(0, system1.getPhase(1), system1.getPhase(0).getNumberOfComponents(), system1.getTemperature(), system1.getPressure())

TPflash(system1)

molardensity_n_heptane_gas = system1.getPhase(0).getComponent('n-heptane').getNumberOfMolesInPhase()/system1.getPhase(0).getVolume();
molardensity_n_heptane_liq = system1.getPhase(1).getComponent('n-heptane').getNumberOfMolesInPhase()/system1.getPhase(1).getVolume();
deltamolardensity_n_heptane = (molardensity_n_heptane_liq - molardensity_n_heptane_gas)/100.0;

molardensity_methane_gas = system1.getPhase(0).getComponent('methane').getNumberOfMolesInPhase()/system1.getPhase(0).getVolume();
molardensity_methane_liq = system1.getPhase(1).getComponent('methane').getNumberOfMolesInPhase()/system1.getPhase(1).getVolume();
deltamolardensity_methane = (molardensity_methane_liq - molardensity_methane_gas)/100.0;

% creates an interface system
system2 = neqsim.thermo.system.SystemSrkEos(280.0,10.0);
system2.addComponent('methane',molardensity_methane_gas);
system2.addComponent('n-heptane',molardensity_n_heptane_gas);
system2.setMixingRule(2);
system2.init(0);
system2.setNumberOfPhases(1);
system2.setUseTVasIndependentVariables(1);
system2.getPhase(0).setTotalVolume(1.0);
system2.init(3);
system2

% changig composition/molardensity of interface (volume of interface is constant
system2.addComponent('methane',deltamolardensity_methane);
system2.addComponent('n-heptane',deltamolardensity_n_heptane);
system2.init_x_y();
system2.init(3);
system2

for n = 1:100
    system2.addComponent('methane',deltamolardensity_methane);
    system2.addComponent('n-heptane',deltamolardensity_n_heptane);
    system2.init_x_y();
    system2.init(3);
    x(n) = system2.getPhase(0).getMolarVolume();
    y(n) = system2.getPhase(0).getPressure();
end

system2

% displaying derivatives of the interface
disp 'interface dchempotdN(0) ', system2.getPhase(0).getComponent(0).getChemicalPotentialdN(0, system2.getPhase(0))
disp 'interface dchempotdN(1) ', system2.getPhase(0).getComponent(0).getChemicalPotentialdN(1, system2.getPhase(0))
disp 'interface dchempotdV ', system2.getPhase(0).getComponent(0).getChemicalPotentialdV(system2.getPhase(0))
disp 'interface Zc ', system2.getPhase(0).getComponent(0).getCriticalCompressibilityFactor()

plot(x,y)