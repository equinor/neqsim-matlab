function saturateWithWater(thermoSystem)
% Saturate thermoSystem with water
% function p = saturateWithWater(thermoSystem)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% DESCRIPTION:
% Saturate thermoSystem with water
%
% EXAMPLE:
% saturateWithWater(thermoSystem);

testFlash = neqsim.thermodynamicoperations.ThermodynamicOperations(thermoSystem);
testFlash.saturateWithWater();