system1 = neqsim.thermo.system.SystemGERGwaterEos(298.15,50.00);
system1.addComponent('methane',0.5);
system1.addComponent('water',0.5);
system1.createDatabase(1);
system1.setMixingRule(8);

num = reshape(magic(4),8,2);
m = size(num);

for n = m:-1:1
    system1.setTemperature(273.15+num(n,1));
    system1.setPressure(num(n,2));
    TPflash(system1,0);
    ppmWater(n) = system1.getPhase(0).getComponent('water').getx()*1e6;
end

% removed because folder does not exist
% XLrange = ['C1:C',num2str(m)];
% xlswrite('c:/prestemp.xls',ppmWater',XLrange);