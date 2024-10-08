function t = hydt(thermoSystem)
% Get hydration temperature of thermoSystem
% function t = hydt(thermoSystem)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OUTPUT:
%  - t            - Hydration temperature
%
% DESCRIPTION:
% Get hydration temperature of thermoSystem
%
% EXAMPLE:
% t = hydt(thermoSystem);

pathNeqSim();

if ~thermoSystem.doHydrateCheck()
    thermoSystem.setHydrateCheck(1);
end
testFlash = neqsim.thermodynamicoperations.ThermodynamicOperations(thermoSystem);
testFlash.setRunAsThread(1);
testFlash.hydrateFormationTemperature();
testFlash.waitAndCheckForFinishedCalculation(100000);
t = thermoSystem.getTemperature();