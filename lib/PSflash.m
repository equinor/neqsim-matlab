function thermoSystem = PSflash(thermoSystem,entropy,display)
% Run PS (pressure, entropy) flash on thermoSystem
% function thermoSystem = PSflash(thermoSystem,entropy,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%  - entropy      - Entropy to use in flash
%
% OPTIONAL INPUT:
%  - display      - Set true to show result. Defaults to false.
%
% OUTPUT:
%  - thermoSystem - Thermodynamic system object
%
% DESCRIPTION:
% Run PS (pressure, entropy) flash on thermoSystem
%
% EXAMPLE:
% thermoSystem = PSflash(thermoSystem,entropy,display);

narginchk(2,3);

pathNeqSim();

if nargin < 3
    display = false;
end

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.PSflash(entropy);
if display
    testFlash.displayResult();
end
clear testFlash;
