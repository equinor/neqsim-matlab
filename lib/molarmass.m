function S = molarmass(thermoSystem,t,p)
% Calculates the molar mass for a given thermodynamic system
% function S = molarmass(thermoSystem,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - t            - Desc
%  - p            - Desc
%
% OUTPUT:
%  - nargout      - Desc
%
% DESCRIPTION:
% Calculates the molar mass for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar helmholtzenergy, gas molar helmholtzenergy, liquid molar helmholtzenergy
% and the number of phases.
%
% Even Solbraa, 2001.
%
% EXAMPLE:
% nargout = molarmass(thermoSystem,t,p);

pathNeqSim();

if nargin > 2
    thermoSystem.setPressure(p);
end
if nargin > 1
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);
S(1) = thermoSystem.getMolarMass;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        S(2) = thermoSystem.getPhase(0).getMolarMass;
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getMolarMass;
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getMolarMass;
    S(3) = thermoSystem.getPhase(1).getMolarMass;
end
S(4) = thermoSystem.getNumberOfPhases;
