function S = gibbsenergy(thermoSystem,t,p)
% Calculates the molar gibbsenergy for a given thermodynamic system
% function S = gibbsenergy(thermoSystem,t,p)
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
% Calculates the molar gibbsenergy for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% The output is mix molar gibbsenergy, gas phase molar gibbsenergy, liquid
% phase molar gibbsenergy and the number of phases.
%
% EXAMPLE:
% S = gibbsenergy(thermoSystem,t,p);

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

S(4) = thermoSystem.getNumberOfPhases();
S(1) = thermoSystem.getGibbsEnergy/thermoSystem.getNumberOfMoles;
if thermoSystem.getNumberOfPhases == 1
    if thermoSystem.getPhase(0).getPhaseType == 1
        S(2) = thermoSystem.getPhase(0).getGibbsEnergy()/thermoSystem.getPhase(0).getNumberOfMolesInPhase();
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getGibbsEnergy()/thermoSystem.getPhase(0).getNumberOfMolesInPhase();
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getGibbsEnergy()/thermoSystem.getPhase(0).getNumberOfMolesInPhase();
    S(3) = thermoSystem.getPhase(1).getGibbsEnergy()/thermoSystem.getPhase(1).getNumberOfMolesInPhase();
end
