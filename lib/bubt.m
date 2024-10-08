function t = bubt(thermoSystem,p)
% Get bubble point temperature of thermoSystem given a pressure
% function t = bubt(thermoSystem,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - p            - Set pressure of thermoSystem
%
% OUTPUT:
%  - t            - Temperature at bubble point
%
% DESCRIPTION:
% Get pressure of thermoSystem after bubble point temperature flash
%
% EXAMPLE:
% p = bubt(thermoSystem);
% p = bubt(thermoSystem,t);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setPressure(p);
end

testFlash = neqsim.thermodynamicoperations.ThermodynamicOperations(thermoSystem);
testFlash.bubblePointTemperatureFlash();
t = thermoSystem.getTemperature();