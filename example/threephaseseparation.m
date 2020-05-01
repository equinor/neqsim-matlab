%specify defined components
definedcomponents.names = {'water', 'methane', 'ethane', 'propane'}
definedcomponents.composition = [0.12 0.1 0.9 0.05]

%specify oil components
oilcomponents.names = {'C7', 'C8'}
oilcomponents.composition = [0.10, 0.220]
oilcomponents.molarmass = [0.10, 0.120]
oilcomponents.relativedensity = [0.7, 0.73]
oilcomponents.plusfraction = 0

% Create a neqsim fluid based on defined and oil components
fieldFluid = fluid(definedcomponents, oilcomponents);

%Initializing the process simulation
resetProcessOperations()

%Create a well stream with the field fluid and set flow, pressure and temperature
fieldWellStream = stream(fieldFluid);
fieldWellStream.setFlowRate(5.0, 'MSm3/day');
fieldWellStream.setTemperature(50.0, 'C');
fieldWellStream.setPressure(50.0, 'bara');

%Add a three phase separator taking the well stream as input. Set
%separation efficiency
wellStreamSeparator = separator(fieldWellStream);

% Set fraction of oil and water to be entrained in gas
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

deltaT = 10.0;

% Gas calculations - evaluating effect on density
%reading gas density at separation temperature and pressure
flash(separatedGasStream.getFluid(),'TP', separatedGasStream.getTemperature("C"), separatedGasStream.getPressure('bara'), "C", "bara");
gasDensityAtSeparatorConditions = separatedGasStream.getFluid().getPhase('gas').getDensity('kg/m3');
gasCompositionAtSeparatorConditions = separatedGasStream.getFluid().getPhase('gas').getComposition('molefraction');
separatedGasStream.getFluid()
%To shwo detailed results of the flash calculation, unncomment the follwong commands:
%separatedGasStream.getFluid()
%printfluid(separatedGasStream.getFluid()

%redusing temperature by a delta T and flash it at constante volume
flash(separatedGasStream.getFluid(),'TV', (separatedGasStream.getTemperature("C")-deltaT), separatedGasStream.getFluid().getVolume("m3"), "C", "m3");
gasDensityAfterTemperatureReduction = separatedGasStream.getFluid().getPhase('gas').getDensity('kg/m3');
gasCompositionAfterTemperatureReduction = separatedGasStream.getFluid().getPhase('gas').getComposition('molefraction');
pressureAfterTemperatureReduction = separatedGasStream.getFluid().getPressure('bara');
%To shwo detailed results of the flash calculation, unncomment the follwong commands:
%separatedGasStream.getFluid()
%printfluid(separatedGasStream.getFluid()
separatedGasStream.getFluid()
changeInDensity = (gasDensityAfterTemperatureReduction-gasDensityAtSeparatorConditions)/gasDensityAtSeparatorConditions*100
%print final results.....