function S = density(thermoSystem,t,p)
% Calculates the density for a given thermodynamic system
% function S = density(thermoSystem,t,p)
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
% Calculates the density for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% The output is mix density, gas density, liquid density
% and the number of phases.
%
% EXAMPLE:
% S = density(thermoSystem,t,p)

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
S(1) = thermoSystem.getDensity;
thermoSystem.getPhase(0).getType
if thermoSystem.getNumberOfPhases == 1
    if thermoSystem.getPhase(0).getType == 'GAS'
        S(2) = thermoSystem.getPhase(0).getDensity();
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getDensity();
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getDensity();
    S(3) = thermoSystem.getPhase(1).getDensity();
end