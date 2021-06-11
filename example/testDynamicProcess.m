global processOperations

resetProcessOperations();

test = thermo('srk',290.0,10.0);
test.addComponent('methane',0.9);
test.addComponent('propane',0.1);
test.addComponent('n-heptane',1.0);
test.createDatabase(1);
test.setMixingRule(2);
TPflash(test)

purgeStream = stream(test,'Purge Stream');

purgeValve = valve(purgeStream,7,'purgv');
purgeValve.setOutletPressure(7.0);
purgeValve.setPercentValveOpening(50.0);

separator_1 = separator(purgeValve.getOutStream(),'inlet sep');

valve_2 = valve(separator_1.getLiquidOutStream(),5.0,'otV2');
valve_2.setPercentValveOpening(50);

valve_3 = valve(separator_1.getGasOutStream(),5.0,'outV');
valve_3.setPercentValveOpening(50);

separatorLevelTransmitter = neqsim.processSimulation.measurementDevice.LevelTransmitter(separator_1);
separatorLevelTransmitter.setName('separatorLEvelTransmitter1');
separatorLevelTransmitter.setUnit('meter');
separatorLevelTransmitter.setMaximumValue(1.0);
separatorLevelTransmitter.setMinimumValue(0.0);

separatorLevelController = neqsim.processSimulation.controllerDevice.ControllerDeviceBaseClass();
separatorLevelController.setReverseActing(false);
separatorLevelController.setTransmitter(separatorLevelTransmitter);
separatorLevelController.setControllerSetPoint(0.3);
separatorLevelController.setControllerParameters(1.0,300.0,10.0);

separatorPressureTransmitter = neqsim.processSimulation.measurementDevice.PressureTransmitter(separator_1.getGasOutStream());
separatorPressureTransmitter.setUnit('bar');
separatorPressureTransmitter.setMaximumValue(10.0);
separatorPressureTransmitter.setMinimumValue(1.0);

separatorPressureController = neqsim.processSimulation.controllerDevice.ControllerDeviceBaseClass();
separatorPressureController.setTransmitter(separatorPressureTransmitter);
separatorPressureController.setReverseActing(false);
separatorPressureController.setControllerSetPoint(7.0);
separatorPressureController.setControllerParameters(1.0,300.0,10.0);

processOperations.add(separatorLevelTransmitter);
valve_2.setController(separatorLevelController);

processOperations.add(separatorPressureTransmitter);
valve_3.setController(separatorPressureController);

runProcess();
% todo: fails [main] ERROR neqsim.thermo.phase.PhaseEos - Failed to solve for molarVolume within the iteration limit.
processOperations.runTransient();

processOperations.setTimeStep(30.0);
i = 0;

for K = 1:10
    processOperations.runTransient();
end
