function t = dewt(testSystem,pressure)
if nargin == 2
    testSystem.setPressure(pressure);
end
testSystem.init(0)
testSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.dewPointTemperatureFlash;
t = testSystem.getTemperature;
clear testFlash;