% The script will perform the following operations:
% 1. Create a neqsim fluid with defined and oil components. The properties
% of the defined components are read from the neqsim database, and the
% properties of oil components are calculated from neqsim fluid
% characterization methods
% 2. Set up a process calculation with a well stream, a three phase separator with input of separation efficiencies, and resulting gas, oil and water streams.
% 3. Select the resulting gas stream and read the density of the gas phase
% in this stream
% 4. Run a TV flash of the gas stream at constant volume and a specified
% temperature
% 5. Read the resulting pressure and gas phase denisty, and evaluate the
% change in gas density


%1. Specify defined components
definedcomponents.names = {'water', 'methane', 'ethane', 'propane'};
definedcomponents.composition = [0.1 0.7 0.05 0.05];

%specify oil components
oilcomponents.names = {'C7', 'C8'};
oilcomponents.composition = [0.05, 0.05];
oilcomponents.molarmass = [0.10, 0.120];
oilcomponents.relativedensity = [0.7, 0.73];
oilcomponents.plusfraction = 0;

% Create a neqsim fluid based on defined and oil components
fieldFluid = fluid(definedcomponents, oilcomponents);

%2. Initializing the process simulation
resetProcessOperations();

%Create a well stream with the field fluid and set flow, pressure and temperature
fieldWellStream = stream(fieldFluid);
fieldWellStream.setFlowRate(5.0, 'MSm3/day');
fieldWellStream.setTemperature(50.0, 'C');
fieldWellStream.setPressure(50.0, 'bara');

%Add a three phase separator taking the well stream as input. Set
%separation efficiency
wellStreamSeparator = separator(fieldWellStream);

% Set fraction of gas/oil/water to be entrained in gas/oil/water
wellStreamSeparator.setEntrainment(0.01, "", "oil", "gas");
wellStreamSeparator.setEntrainment(0.01, "", "aqueous", "gas");
% Set fraction of gas and water to be entrained in oil
wellStreamSeparator.setEntrainment(0.01, "", "gas", "oil");
wellStreamSeparator.setEntrainment(0.01, "", "aqueous", "oil");
% Set fraction of gas and oil to be entrained in aqueous
wellStreamSeparator.setEntrainment(0.01, "", "gas", "aqueous");
wellStreamSeparator.setEntrainment(0.01, "", "oil", "aqueous");

% Creating the gas, oil and water streams from the separator
separatedGasStream = stream(wellStreamSeparator.getGasOutStream());
separatedOilStream = stream(wellStreamSeparator.getOilOutStream());
separatedAqueousStream = stream(wellStreamSeparator.getWaterOutStream());

%running the process
runProcess();

% 3. Select the resulting gas stream and read the density of the gas phase in this stream
gasDensityAtSeparatorConditions = separatedGasStream.getFluid().getPhase('gas').getDensity('kg/m3');
gasCompositionAtSeparatorConditions = separatedGasStream.getFluid().getPhase('gas').getComposition('molefraction');
separatedGasStream.getFluid()

%4. Reduce temperature by delta T and flash it at constant volume
deltaT = 10.0;
flash(separatedGasStream.getFluid(),'TV', (separatedGasStream.getTemperature("C")-deltaT), separatedGasStream.getFluid().getVolume("m3"), "C", "m3");
gasDensityAfterTemperatureReduction = separatedGasStream.getFluid().getPhase('gas').getDensity('kg/m3');
gasCompositionAfterTemperatureReduction = separatedGasStream.getFluid().getPhase('gas').getComposition('molefraction');
pressureAfterTemperatureReduction = separatedGasStream.getFluid().getPressure('bara');
separatedGasStream.getFluid()

%Calculate change in fluid density
changeInDensity = (gasDensityAfterTemperatureReduction-gasDensityAtSeparatorConditions)/gasDensityAtSeparatorConditions*100
%print final results.....