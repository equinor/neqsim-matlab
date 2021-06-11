system1 = neqsim.thermo.system.SystemSrkEos(280,10);
system1.addComponent('methane',10.0);
system1.addComponent('CO2',1.0);
system1.setMixingRule(2);

%example of direct calculation of results
results = system1.calcResultTable();

system1.initProperties();
ent1 = system1.getEnthalpy('kJ/kg')

resetProcessOperations()
stream1 = stream(system1,'troll1');
runProcess()
streamResults = stream1.getResultTable();