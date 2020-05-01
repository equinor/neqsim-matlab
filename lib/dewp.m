function p = dewp(testSystem,t)
if nargin == 2
    testSystem.setTemperature(t);
end
testSystem.init(0)
testSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.dewPointPressureFlash;
p = testSystem.getPressure
clear testFlash;