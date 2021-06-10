function t = freezt(thermoSystem,p)
% Summary description
% function t = freezt(thermoSystem,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - p            - Set pressure of thermoSystem
%
% OUTPUT:
%  - t            - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% t = freezt(thermoSystem,pressure);

pathNeqSim();

if nargin > 2
    thermoSystem.setPressure(p);
end
thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.freezingPointTemperatureFlash();
t = thermoSystem.getTemperature();
clear testFlash;
