function S = enthalpy(thermoSystem,t,p)
% Calculates the enthalpy for a given thermodynamic system
% function S = enthalpy(thermoSystem,t,p)
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
% Calculates the enthalpy for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar enthalpy, gas molar enthalpy, liquid molar enthalpy
% and the number of phases.
%
% Even Solbraa, 2001.
%
% EXAMPLE:
% S = enthalpy(thermoSystem,t,p);

if (nargin >= 3)
    thermoSystem.setPressure(p);
end
if (nargin >= 2)
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(3);
S(1) = thermoSystem.getEnthalpy/thermoSystem.getNumberOfMoles;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        S(2) = thermoSystem.getPhase(0).getEnthalpy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getEnthalpy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getEnthalpy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
    S(3) = thermoSystem.getPhase(1).getEnthalpy/thermoSystem.getPhase(1).getNumberOfMolesInPhase;
end
S(4) = thermoSystem.getNumberOfPhases;
