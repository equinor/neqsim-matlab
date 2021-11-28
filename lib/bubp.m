function p = bubp(thermoSystem,t)
% Get bubble point pressure of thermoSystem given a temperature
% function p = bubp(thermoSystem,t)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - t            - Set temperature of thermoSystem
%
% OUTPUT:
%  - p            - Pressure at bubble point
%
% DESCRIPTION:
% Get thermoSystem pressure after bubblepoint pressure flash
%
% EXAMPLE:
% p = bubp(thermoSystem);
% p = bubp(thermoSystem,t);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setTemperature(t);
end

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.bubblePointPressureFlash(0);
p = thermoSystem.getPressure();