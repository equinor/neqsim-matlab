function t = freezt(thermoSystem,pressure)
% Summary description
% function t = freezt(thermoSystem,pressure)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - pressure   - Set pressure of thermoSystem
%
% OUTPUT:
%  - t          - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% t = freezt(thermoSystem,pressure);

pathNeqSim();

if nargin > 2
    thermoSystem.setPressure(pressure);
end
thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.freezingPointTemperatureFlash();
t = thermoSystem.getTemperature();
clear testFlash;
