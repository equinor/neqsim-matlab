function thermoSystem = PSflash(thermoSystem,entropy,display)
% Summary description
% function thermoSystem = PSflash(thermoSystem,entropy,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%  - entropy    - Desc
%
% OPTIONAL INPUT:
%  - display    - Desc
%
% OUTPUT:
%  - thermoSystem - Desc
%
% DESCRIPTION:
%
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
