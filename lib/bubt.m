function p = bubt(thermoSystem,t)
% Get pressure of thermoSystem after bubble point temperature flash
% function p = bubt(thermoSystem,t)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - t            - Temperature. Defaults to thermoSystem temperature
%
% OUTPUT:
%  - p            - Pressure of thermoSystem after flash
%
% DESCRIPTION:
% Get pressure of thermoSystem after bubble point temperature flash
%
% EXAMPLE:
% p = bubt(thermoSystem,t);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setTemperature(t);
end

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.bubblePointTemperatureFlash();
p = thermoSystem.getPressure();
clear testFlash;