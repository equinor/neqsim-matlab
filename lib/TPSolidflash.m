function thermoSystem = TPSolidflash(thermoSystem)
% Summary description
% function thermoSystem = TPSolidflash(thermoSystem)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
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
