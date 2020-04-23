pressure = 10.0;                                % pressure in bara
temperature = 273.15;                           % temperature in Kelvin
 
fluid_1 = thermo('srk', temperature, pressure); % using the SRK-EoS
 
fluid_1.addComponent('methane', 1.0);       	% adding 1 mole/second of methane
fluid_1.addComponent('propane', 1.0);      	 	% adding 1 mole/second of propane
 
fluid_1.createDatabase(1);                      % reading new parameters from database
fluid_1.setMixingRule(2);           			% using classic mixing rule with kij

TPflash(fluid_1)                                % doing a flash at constant pressure and temperature

initialEnthalpy = fluid_1.getEnthalpy;          % reading enthalpy of fluid
fluid_1.setPressure(1.0);                       % setting pressure to 1.0 bara
%PHflash(fluid_1, initialEnthalpy);              % doing a flash at given enthalpy and pressure
fluid_1.getTemperature                          % reading resulting temperature