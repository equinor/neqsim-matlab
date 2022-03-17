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
%  - S            - Output array
%
% DESCRIPTION:
% Calculates the number of moles in phase for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% The output is number of moles in total, number of moles in gas phase,
% number of moles in liquid phase and the number of phases.
%
% EXAMPLE:
% S = moles(thermoSystem,t,p);

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
S(1) = thermoSystem.getNumberOfMoles();
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