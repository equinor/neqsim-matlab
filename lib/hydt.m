function t = hydt(thermoSystem)
% Summary description
% function t = hydt(thermoSystem)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OUTPUT:
%  - t          - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% t = hydt(thermoSystem);

pathNeqSim();

if ~thermoSystem.doHydrateCheck()
    thermoSystem.setHydrateCheck(1);
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.setRunAsThread(1);
testFlash.hydrateFormationTemperature();
testFlash.waitAndCheckForFinishedCalculation(100000);
t = thermoSystem.getTemperature();
clear testFlash;
