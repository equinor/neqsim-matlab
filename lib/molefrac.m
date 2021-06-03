function S = molefrac(thermoSystem,i,t,p)
% Summary description
% function S = molefrac(thermoSystem,i,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%  - i            - Desc
%
% OPTIONAL INPUT:
%  - t            - Desc
%  - p            - Desc
%
% OUTPUT:
%  - nargout      - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% nargout = molefrac(thermoSystem,i,t,p);

% Calculates the molefraction of component i in a phase for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is number of moles in phase, gas number of moles in phase, liquid number of moles in phase
% and the number of phases.
%
% Even Solbraa, 2001.
%
if nargin > 3
    thermoSystem.setPressure(p);
end
if nargin > 2
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);
S(1) = thermoSystem.getPhase(0).getComponent(i).getz;
if thermoSystem.getNumberOfPhases == 1
    if thermoSystem.getPhase(0).getPhaseType == 1
        S(2) = thermoSystem.getPhase(0).getComponent(i).getx;
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getComponent(i).getx;
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getComponent(i).getx;
    S(3) = thermoSystem.getPhase(1).getComponent(i).getx;
end
S(4) = thermoSystem.getNumberOfPhases;
