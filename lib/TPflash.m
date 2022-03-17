function [thermoSystem, hFig] = TPflash(thermoSystem,display)
% Run TP (temperature, pressure) flash on thermoSystem
% function [thermoSystem, hFig] = TPflash(thermoSystem,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - display      - Set true to show result. Defaults to false.
%
% OUTPUT:
%  - thermoSystem - Thermodynamic system object
%
% DESCRIPTION:
% Run TP (temperature, pressure) flash on thermoSystem
%
% EXAMPLE:
% thermoSystem = TPflash(thermoSystem,display);

narginchk(1,2)

pathNeqSim();

if nargin < 2
    display = nargout > 1;
end

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.TPflash();

if display
    hFig = show(thermoSystem);
end