function S = viscosity(thermoSystem,t,p)
% Calculates the viscosity for a given thermodynamic system
% function S = viscosity(thermoSystem,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - t            - Set temperature of thermoSystem
%  - p            - Set pressure of thermoSystem
%
% OUTPUT:
%  - S            - Array with system viscosity, gas viscosity, liquid viscosity
% and the number of phases.
%
% DESCRIPTION:
% Calculates the viscosity for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
%
% EXAMPLE:
% S = viscosity(thermoSystem,t,p);

narginchk(1,3);

if nargin > 2
    thermoSystem.setPressure(p);
end
if nargin > 1
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);
thermoSystem.initPhysicalProperties;

S(4) = thermoSystem.getNumberOfPhases();
S(1) = thermoSystem.getViscosity();
if thermoSystem.getNumberOfPhases() == 1
    if thermoSystem.getPhase(0).getPhaseType() == 1
        S(2) = thermoSystem.getPhase(0).getPhysicalProperties.getViscosity();
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getPhysicalProperties.getViscosity();
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getPhysicalProperties.getViscosity();
    S(3) = thermoSystem.getPhase(1).getPhysicalProperties.getViscosity();
end