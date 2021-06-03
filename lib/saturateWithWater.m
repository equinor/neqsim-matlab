function p = saturateWithWater(thermoSystem)
% Summary description
% function p = saturateWithWater(thermoSystem)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OUTPUT:
%  - p          - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% p = saturateWithWater(thermoSystem);

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.saturateWithWater();
p = testFlash.getPressure();
clear testFlash;
