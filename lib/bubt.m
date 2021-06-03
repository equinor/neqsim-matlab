function p = bubt(thermoSystem,t)
% Summary description
% function p = bubt(thermoSystem,t)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - t          - Desc
%
% OUTPUT:
%  - p          - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% p = bubt(thermoSystem,t);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setTemperature(t);
end

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.bubblePointTemperatureFlash();
clear testFlash;
p = thermoSystem.getPressure();
