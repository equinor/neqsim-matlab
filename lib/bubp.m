function p = bubp(thermoSystem,t)
% Get thermoSystem pressure after bubblepoint pressure flash
% function p = bubp(thermoSystem,t)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - t            - Temperature. Defaults to thermoSystem temperature
%
% OUTPUT:
%  - p            - Pressure
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
clear testFlash;