run 'G:\T&P\F&T\PRA\Gassprosessering\Dataverktøy\neqsim\neqsim\toolbox\matlab\addpathNeqSim'
InitNeqSim

test = thermo('GERG2004',255.32, 6);
test.addComponent('methane', 10.01);
test.addComponent('ethane', 0.099);
test.createDatabase(1);

TPflash(test,0);

test

