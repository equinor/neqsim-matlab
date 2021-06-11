function t = dewt(thermoSystem,p)
% Summary description
% function t = dewt(thermoSystem,p)
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
% t = dewt(thermoSystem,p);

pathNeqSim();

if nargin > 1
    thermoSystem.setPressure(p);
end
thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.dewPointTemperatureFlash;
t = thermoSystem.getTemperature;
clear testFlash;
