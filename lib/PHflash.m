function thermoSystem = PHflash(thermoSystem,enthalpy,display)
% Summary description
% function thermoSystem = PHflash(thermoSystem,enthalpy,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%  - enthalpy   - Desc
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
% thermoSystem = PHflash(thermoSystem,enthalpy,display);

narginchk(2,3);

pathNeqSim();

if nargin < 3
    display = false;
end

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.PHflash(enthalpy,0);
if display
    testFlash.displayResult();
end
clear testFlash;
