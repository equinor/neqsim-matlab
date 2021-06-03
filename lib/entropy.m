function S = entropy(thermoSystem,t,p)
% Summary description
% function S = entropy(thermoSystem,t,p)
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
% Calculates the entropy for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar entropy, gas molar entropy, liquid molar entropy
% and the number of phases.
%
% Even Solbraa, 2001.
%
% EXAMPLE:
% nargout = entropy(thermoSystem,t,p);

if nargin > 2
    thermoSystem.setPressure(p);
end
if nargin > 1
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(3);
S(1) = thermoSystem.getEntropy/thermoSystem.getNumberOfMoles;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        S(2) = thermoSystem.getPhase(0).getEntropy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getEntropy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getEntropy/thermoSystem.getPhase(0).getNumberOfMolesInPhase();
    S(3) = thermoSystem.getPhase(1).getEntropy/thermoSystem.getPhase(1).getNumberOfMolesInPhase();
end
S(4) = thermoSystem.getNumberOfPhases();
