function [thermoSystem, hFig] = TPflash(thermoSystem,display)
% Summary description
% function [thermoSystem, hFig] = TPflash(thermoSystem,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
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
    hFig = show(thermoSystem);
end
clear testFlash;
