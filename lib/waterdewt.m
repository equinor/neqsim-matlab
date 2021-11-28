function t = waterdewt(thermoSystem,p)
% Get water dew point temperature of a thermoSystem
% function t = waterdewt(thermoSystem,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - p            - Set thermoSystem pressure
%
% OUTPUT:
%  - t            - Water dew point temperature
%
% DESCRIPTION:
% Get water dew point temperature of a thermoSystem
%
% EXAMPLE:
% t = waterdewt(thermoSystem);
% t = waterdewt(thermoSystem,pressure);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setPressure(p);
end

thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.waterDewPointTemperatureFlash();
t = thermoSystem.getTemperature();