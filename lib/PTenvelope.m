function [testFlash, hFig] = PTenvelope(thermoSystem,display)
% Run PT (pressure, temperature) flashes on thermoSystem to get PT envelope
% function [testFlash, hFig] = PTenvelope(thermoSystem,display)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - display      - Set true to show result. Defaults to false.
%
% OUTPUT:
%  - testFlash  - Desc
%
% DESCRIPTION:
% Run PT (pressure, temperature) flashes on thermoSystem to get PT envelope
%
% EXAMPLE:
% testFlash = PTenvelope(thermoSystem);

narginchk(1,2);

pathNeqSim();

if nargin < 2
    display = nargout > 1;
end

thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicoperations.ThermodynamicOperations(thermoSystem);
testFlash.calcPTphaseEnvelope();

if display
    hFig = show(thermoSystem);
end