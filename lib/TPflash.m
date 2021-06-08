function [thermoSystem, hFig] = TPflash(thermoSystem,display)
% Summary description
% function thermoSystem = TPflash(thermoSystem,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - display      - Set true to show result. Defaults to false.
%
% OUTPUT:
%  - thermoSystem - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% thermoSystem = TPflash(thermoSystem,display);

pathNeqSim();

if nargin < 2
    display = false;
end
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.TPflash();
if display
    T = cell2table(cell(thermoSystem.createTable("test")));
    hFig = uitableplot(T);
else
    hFig = gobjects(1);
%     testFlash.displayResult();
end
clear testFlash;
