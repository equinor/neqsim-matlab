function S = gibbsenergy(thermoSystem,t,p)
% Summary description
% function S = gibbsenergy(thermoSystem,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - t            - Desc
%  - p            - Desc
%
% OUTPUT:
%  - S      - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% nargout = gibbsenergy(thermoSystem,t,p);

% Calculates the gibbsenergy for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar gibbsenergy, gas molar gibbsenergy, liquid molar gibbsenergy
% and the number of phases.
%
% Even Solbraa, 2001.

if nargin > 2
    thermoSystem.setPressure(p);
end
if nargin > 1
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);
S(1) = thermoSystem.getGibbsEnergy/thermoSystem.getNumberOfMoles;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        S(2) = thermoSystem.getPhase(0).getGibbsEnergy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getGibbsEnergy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getGibbsEnergy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
    S(3) = thermoSystem.getPhase(1).getGibbsEnergy/thermoSystem.getPhase(1).getNumberOfMolesInPhase;
end
S(4) = thermoSystem.getNumberOfPhases();
