function p = bubt(testSystem, t)
     if nargin==2
         testSystem.setTemperature(t);
     end
     testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
     testFlash.bubblePointTemperatureFlash();
     clear testFlash;
     p = testSystem.getPressure