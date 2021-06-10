function testFlash = PTenvelope(thermoSystem,display)
% Summary description
% function testFlash = PTenvelope(thermoSystem,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - display      - Set true to show result. Defaults to false.
%
% OUTPUT:
%  - testFlash  - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% testFlash = PTenvelope(thermoSystem);

narginchk(1,2);

pathNeqSim();

if nargin < 2
    display = false;
end

thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.calcPTphaseEnvelope();
if display
    testFlash.displayResult();
end
