function S = moles(thermoSystem,t,p)
% Calculates the number of moles in phase for a given thermodynamic system
% function S = moles(thermoSystem,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - t            - Desc
%  - p            - Desc
%
% OUTPUT:
%  - S            - Array of number of moles in phase, gas number of moles in phase, liquid number of moles in phase
% and the number of phases
%
% DESCRIPTION:
% Calculates the number of moles in phase for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
%
% EXAMPLE:
% S = moles(thermoSystem,t,p);

if nargin > 2
    thermoSystem.setPressure(p);
end
if nargin > 1
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);

S(4) = thermoSystem.getNumberOfPhases();
S(1) = thermoSystem.getNumberOfMoles;
if thermoSystem.getNumberOfPhases == 1
    if thermoSystem.getPhase(0).getPhaseType == 1
        S(2) = thermoSystem.getPhase(0).getNumberOfMolesInPhase();
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getNumberOfMolesInPhase();
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getNumberOfMolesInPhase();
    S(3) = thermoSystem.getPhase(1).getNumberOfMolesInPhase();
end