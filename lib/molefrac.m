function S = molefrac(thermoSystem,n,t,p)
% Calculates the molefraction of component n in a phase for a given thermodynamic system
% function S = molefrac(thermoSystem,n,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%  - n            - Component number
%
% OPTIONAL INPUT:
%  - t            - Set temperature of thermoSystem
%  - p            - Set pressure of thermoSystem
%
% OUTPUT:
%  - S            - Output array
%
% DESCRIPTION:
% Calculates the molefraction of component n in a phase for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% The output is molefraction of component n in mix, molefraction of
% component n in gas phase, molefraction of component n in liquid phase and
% the number of phases.
%
% EXAMPLE:
% S = molefrac(thermoSystem,i,t,p);

% Even Solbraa, 2001.

if nargin > 3
    thermoSystem.setPressure(p);
end
if nargin > 2
    if ~isempty(t)
        thermoSystem.setTemperature(t);
    end
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);

S(4) = thermoSystem.getNumberOfPhases();
S(1) = thermoSystem.getPhase(0).getComponent(n).getz();
if thermoSystem.getNumberOfPhases == 1
    if thermoSystem.getPhase(0).getPhaseType == 1
        S(2) = thermoSystem.getPhase(0).getComponent(n).getx();
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getComponent(n).getx();
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getComponent(n).getx();
    S(3) = thermoSystem.getPhase(1).getComponent(n).getx();
end