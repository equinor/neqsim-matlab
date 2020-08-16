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
definedcomponents.names = {'water', 'nitrogen', 'CO2', 'methane','ethane','propane', 'i-butane', 'n-butane', 'i-pentane', 'n-pentane'};
definedcomponents.composition = [0.1 0.0033 0.0551 0.72884 0.09416 0.03777 0.0065 0.01135 0.00395 0.00425];

%specify oil components
oilcomponents.names = {'C6','C7', 'C8','C9','C10'};
oilcomponents.composition = [0.00505,0.00888,0.00987,0.00604,0.02454];
oilcomponents.molarmass = [0.10,0.12,0.14,0.15, 0.207];
oilcomponents.relativedensity = [0.7,0.73,0.75,0.77,0.841];
oilcomponents.plusfraction = 1;

% Create a neqsim fluid based on defined and oil components
fieldFluid = fluid(definedcomponents,oilcomponents);

%2. Initializing the process simulation
resetProcessOperations();

%Create a well stream with the field fluid and set flow, pressure and temperature
fieldWellStream = stream(fieldFluid);
fieldWellStream.setFlowRate(5.0,'MSm3/day');
fieldWellStream.setTemperature(80.0,'C');
fieldWellStream.setPressure(150.0,'bara');

%Add a three phase separator taking the well stream as input. Set
%separation efficiency
wellStreamSeparator = separator(fieldWellStream);

% Set fraction of gas/oil/water to be entrained in gas/oil/water
wellStreamSeparator.setEntrainment(0.05,"","oil","gas");
wellStreamSeparator.setEntrainment(0.01,"","aqueous","gas");
% Set fraction of gas and water to be entrained in oil
wellStreamSeparator.setEntrainment(0.001,"","gas","oil");
wellStreamSeparator.setEntrainment(0.001,"","aqueous","oil");
% Set fraction of gas and oil to be entrained in aqueous
wellStreamSeparator.setEntrainment(0.001,"","gas","aqueous");
wellStreamSeparator.setEntrainment(0.01,"","oil","aqueous");

% Creating the gas, oil and water streams from the separator
separatedGasStream = stream(wellStreamSeparator.getGasOutStream());
separatedOilStream = stream(wellStreamSeparator.getOilOutStream());
separatedAqueousStream = stream(wellStreamSeparator.getWaterOutStream());

%running the process
runProcess();

% 3. Select the resulting gas stream and read the density of the gas phase in this stream
gasDensityAtSeparatorConditions = separatedGasStream.getFluid().getPhase('gas').getDensity('kg/m3');
oilDensityAtSeparatorConditions = separatedOilStream.getFluid().getPhase('oil').getDensity('kg/m3');
gasCompositionAtSeparatorConditions = separatedGasStream.getFluid().getPhase('gas').getComposition('molefraction');
volumeFractionGasInOilSample = separatedOilStream.getFluid().getPhaseFraction('gas',"volume");
volumeFractionOilInGasSample = separatedGasStream.getFluid().getPhaseFraction('oil',"volume");

separatedGasStream.getFluid()
separatedOilStream.getFluid()
%4. Reduce temperature by delta T and flash it at constant volume
for cdeltaT = 1:10
    deltaT = 1.0;
    flash(separatedGasStream.getFluid(),'TV',(separatedGasStream.getTemperature("C") - deltaT),separatedGasStream.getFluid().getVolume("m3"),"C","m3");
    flash(separatedOilStream.getFluid(),'TV',(separatedOilStream.getTemperature("C") - deltaT),separatedOilStream.getFluid().getVolume("m3"),"C","m3");
    gasDensityAfterTemperatureReduction = separatedGasStream.getFluid().getPhase('gas').getDensity('kg/m3');
    oilDensityAfterTemperatureReduction = separatedOilStream.getFluid().getPhase('oil').getDensity('kg/m3');
    gasCompositionAfterTemperatureReduction = separatedGasStream.getFluid().getPhase('gas').getComposition('molefraction');
    pressureAfterTemperatureReduction = separatedGasStream.getFluid().getPressure('bara');
    %separatedGasStream.getFluid()
    %separatedOilStream.getFluid()
    
    %Calculate change in fluid density
    changeInDensityGas(cdeltaT) = (gasDensityAfterTemperatureReduction - gasDensityAtSeparatorConditions)/gasDensityAtSeparatorConditions*100;
    changeInDensityOil(cdeltaT) = (oilDensityAfterTemperatureReduction - oilDensityAtSeparatorConditions)/oilDensityAtSeparatorConditions*100;
end

%print final results.....