function p = dewp(thermoSystem,t)
% Get dew point pressure of thermoSystem given a temperature
% function p = dewp(thermoSystem,t)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - t            - Set temperature of thermoSystem
%
% OUTPUT:
%  - p            - Pressure at dew point
%
% DESCRIPTION:
% Get thermoSystem pressure after dew point pressure flash
%
% EXAMPLE:
% p = dewp(thermoSystem);
% p = dewp(thermoSystem,t);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setTemperature(t);
end

thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.dewPointPressureFlash();
p = thermoSystem.getPressure();