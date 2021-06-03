function t = dewt(thermoSystem,pressure)
% Summary description
% function t = dewt(thermoSystem,pressure)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - pressure   - Desc
%
% OUTPUT:
%  - t          - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% t = dewt(thermoSystem,pressure);

pathNeqSim();

if nargin > 1
    thermoSystem.setPressure(pressure);
end
thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.dewPointTemperatureFlash;
t = thermoSystem.getTemperature;
clear testFlash;
