function thermoSystem = TPSolidflash(thermoSystem,display)
% Summary description
% function thermoSystem = TPSolidflash(thermoSystem,display)
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
% thermoSystem = TPSolidflash(thermoSystem);

narginchk(1,1);

pathNeqSim();

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.TPSolidflash();
if display
    show(thermoSystem)
end
