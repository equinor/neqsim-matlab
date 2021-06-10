function thermoSystem = PHflash(thermoSystem,enthalpy,display)
% Run PH (pressure, enthalpy) flash on thermoSystem
% function thermoSystem = PHflash(thermoSystem,enthalpy,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%  - enthalpy     - Enthalpy to use in flash
%
% OPTIONAL INPUT:
%  - display      - Set true to show result. Defaults to false.
%
% OUTPUT:
%  - thermoSystem - Desc
%
% DESCRIPTION:
% Run PH (pressure, enthalpy) flash on thermoSystem
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
