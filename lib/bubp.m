function p = bubp(testSystem,t)
if nargin == 2
    testSystem.setTemperature(t);
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.bubblePointPressureFlash(0);
clear testFlash;
p = testSystem.getPressure