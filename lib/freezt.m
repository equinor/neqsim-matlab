function t = freezt(thermoSystem,p)
% Get freezing temperature of thermosystem at a given pressure
% function t = freezt(thermoSystem,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - p            - Set pressure of thermoSystem
%
% OUTPUT:
%  - t            - Freezing temperature
%
% DESCRIPTION:
% Get freezing temperature of thermosystem at a given pressure
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