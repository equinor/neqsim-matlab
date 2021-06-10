function S = Z(thermoSystem,t,p)
% Get kinematic viscosity of thermoSystem
% function S = Z(thermoSystem,t,p)
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
% Calculates the kinematic viscosity for a given thermodyanmic system
% If temperature or pressure are specified - a TP flash is done.
% The output is total molar kinematic viscosity, gas molar kinematic viscosity, 
% liquid molar kinematic viscosity and the number of phases.
%
% Even Solbraa, 2001.
%
if nargin > 2
    thermoSystem.setPressure(p);
end
if nargin > 1
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end

thermoSystem.init(2);
S(4) = thermoSystem.getNumberOfPhases();
S(1) = thermoSystem.getZ();
if thermoSystem.getNumberOfPhases == 1
    if thermoSystem.getPhase(0).getPhaseType == 1
        S(2) = thermoSystem.getPhase(0).getZ();
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getZ();
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getZ();
    S(3) = thermoSystem.getPhase(1).getZ();
end