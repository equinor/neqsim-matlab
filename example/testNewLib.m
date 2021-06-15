system1 = thermo('srk', 290.0, 10.0);
system1.addComponent('methane',10.0);
system1.addComponent('CO2',1.0);
system1.setMixingRule(2);
%example of direct calculation of results
results = cell(system1.calcResultTable());
show(system1);

system1.initProperties();
ent1 = system1.getEnthalpy('kJ/kg');

resetProcessOperations()
stream1 = stream(system1,'troll1');
runProcess();
streamResults = cell(stream1.getResultTable());
show(stream1);