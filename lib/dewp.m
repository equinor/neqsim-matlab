function p = dewp(thermoSystem,t)
% Summary description
% function p = dewp(thermoSystem,t)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - t          - Desc
%
% OUTPUT:
%  - p          - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% p = dewp(thermoSystem,t);

pathNeqSim();

if nargin > 1
    thermoSystem.setTemperature(t);
end
thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(thermoSystem);
testFlash.dewPointPressureFlash;
clear testFlash;
p = thermoSystem.getPressure();

