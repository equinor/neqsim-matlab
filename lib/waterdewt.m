function t = waterdewt(testSystem,pressure)
%
% function t = waterdewt(testSystem,pressure)
%
% INPUT:
%  - testSystem
%
% OPTIONAL INPUT:
%  - pressure
%
% OUTPUT:
%  - t
%
% DESCRIPTION:
%
pathNeqSim();

if nargin > 1
    testSystem.setPressure(pressure);
end
testSystem.init(0)
testSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
testFlash.waterDewPointTemperatureFlash();
t = testSystem.getTemperature;
clear testFlash;