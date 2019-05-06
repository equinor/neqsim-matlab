fluid1 = thermo('electrolyteCPA', 298.0, 10.0);
fluid1.addComponent("CO2",1.0, 'kg/sec');
fluid1.addComponent("water", 1.0, 'kg/sec')
fluid1.addComponent("Na+", 2.5, 'mol/sec');
fluid1.addComponent("Cl-", 2.5, 'mol/sec');
fluid1.addComponent("Ca++", 5.0e-1, 'mol/sec');
fluid1.addComponent("SO4--", 5.0e-1, 'mol/sec');

fluid1.chemicalReactionInit();
fluid1.createDatabase(1)
fluid1.setMixingRule(4);
TPflash(fluid1,0);

temp = 0;
func = 0;
func2 = 0;
func3 = 0;
ph = 0
for i=1:10
    fluid1.setTemperature(313.15);
    fluid1.setPressure(0.05+10.0*i);
    TPflash(fluid1,0);
    temp(i) = fluid1.getPressure();
    func(i) = fluid1.getPhase(1).getComponent('CO2').getx();%()/(fluid1.getPhase(1).getComponent('water').getNumberOfMolesInPhase()*fluid1.getPhase(1).getComponent('water').getMolarMass());
    func2(i) = fluid1.getPhase(1).getComponent('HCO3-').getNumberOfMolesInPhase()/(fluid1.getPhase(1).getComponent('water').getNumberOfMolesInPhase()*fluid1.getPhase(1).getComponent('water').getMolarMass());
    func3(i) = fluid1.getPhase(1).getComponent('CO3--').getNumberOfMolesInPhase()/(fluid1.getPhase(1).getComponent('water').getNumberOfMolesInPhase()*fluid1.getPhase(1).getComponent('water').getMolarMass());
    ph(i) = fluid1.getPhase(1).getpH()
    fluid1.initPhysicalProperties()
end
hold off
plot(temp,func);
hold on
%plot(temp,func2);
%plot(temp,func3);