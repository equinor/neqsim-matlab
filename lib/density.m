function S = density(thermoSystem,t,p)
%
% function S = density(thermoSystem,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - t
%  - p
%
% DESCRIPTION:
% Calculates the density for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% The output is total density, gas density, liquid density
% and the number of phases.
%
% EXAMPLE:
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
S(1) = thermoSystem.getDensity;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        S(2) = thermoSystem.getPhase(0).getDensity;
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getDensity;
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getDensity;
    S(3) = thermoSystem.getPhase(1).getDensity;
end
S(4) = thermoSystem.getNumberOfPhases;