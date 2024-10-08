function [thermoSystem, hFig] = TPSolidflash(thermoSystem,display)
% Run TP (temperature, pressure) solid flash on thermoSystem
% function [thermoSystem, hFig] = TPSolidflash(thermoSystem,display)
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
% Run TP (temperature, pressure) solid flash on thermoSystem
%
% EXAMPLE:
% thermoSystem = TPSolidflash(thermoSystem);

narginchk(1,2);

pathNeqSim();

if nargin < 2
    display = nargout > 1;
end

testFlash = neqsim.thermodynamicoperations.ThermodynamicOperations(thermoSystem);
testFlash.TPSolidflash();

if display
    hFig = show(thermoSystem);
end