function t = dewt(thermoSystem,p)
% Get dew point temperature of thermoSystem given a pressure
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
% Get temperature of thermoSystem after dew point temperature flash
%
% EXAMPLE:
% t = dewt(thermoSystem);
% t = dewt(thermoSystem,p);

narginchk(1,2);

pathNeqSim();

if nargin > 1
    thermoSystem.setPressure(p);
end

thermoSystem.init(0)
thermoSystem.init(1)
testFlash = neqsim.thermodynamicoperations.ThermodynamicOperations(thermoSystem);
testFlash.dewPointTemperatureFlash();
t = thermoSystem.getTemperature();