function p = bubp(thermoSystem,t)
% Summary description
% function p = bubp(thermoSystem,t)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%  - t          - Desc
%
% OUTPUT:
%  - p          - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% p = bubp(thermoSystem,t);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setTemperature(t);
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.bubblePointPressureFlash(0);
clear testFlash;
p = thermoSystem.getPressure();
