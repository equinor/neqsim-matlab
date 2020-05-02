function t = waterdewt(testSystem,pressure)
if nargin == 2
    testSystem.setPressure(pressure);
end
testSystem.init(0)
testSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.waterDewPointTemperatureFlash();
t = testSystem.getTemperature;
clear testFlash;