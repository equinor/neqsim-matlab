function t = waterdewt(thermoSystem,pressure)
% Get water dew point temperature of a thermoSystem
% function t = waterdewt(thermoSystem,pressure)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - pressure   - Thermosystem pressure
%
% OUTPUT:
%  - t          - Water dew point
%
% DESCRIPTION:
% Get water dew point temperature of a thermoSystem
%
% EXAMPLE:
% t = waterdewt(thermoSystem,pressure);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setPressure(pressure);
end
thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.waterDewPointTemperatureFlash();
t = thermoSystem.getTemperature();
clear testFlash;