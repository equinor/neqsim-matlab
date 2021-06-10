function S = dynvisc(thermoSystem,t,p)
% Calculates the dynamic viscosity for a given thermodynamic system
% function S = dynvisc(thermoSystem,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - t            - Set temperature of thermoSystem
%  - p            - Set pressure of thermoSystem
%
% OUTPUT:
%  - S            - Output array
%
% DESCRIPTION:
% Calculates the dynamic viscosity for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% The output is mix dynamic viscosity, gas phase dynamic viscosity, liquid
% phase dynamic viscosity and the number of phases.
%
% EXAMPLE:
% S = dynvisc(thermoSystem,t,p);

% Even Solbraa, 2001.

if nargin > 2 
    thermoSystem.setPressure(p);
end
if nargin > 1
    if ~isempty(t)
        thermoSystem.setTemperature(t);
    end
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);
thermoSystem.initPhysicalProperties();

S(4) = thermoSystem.getNumberOfPhases();
S(1) = thermoSystem.getViscosity();
if thermoSystem.getNumberOfPhases == 1
    if thermoSystem.getPhase(0).getPhaseType == 1
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
