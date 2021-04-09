function nargout = molarmass(thermoSystem,t,p)
% Calculates the helmholtzenergy for a given thermodyanmic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar helmholtzenergy, gas molar helmholtzenergy, liquid molar helmholtzenergy
% and the number of phases.
%
% Even Solbraa, 2001.

if (nargin >= 3)
    thermoSystem.setPressure(p);
end
if (nargin >= 2)
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);
nargout(1) = thermoSystem.getMolarMass;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        nargout(2) = thermoSystem.getPhase(0).getMolarMass;
        nargout(3) = 0;
    else
        nargout(3) = thermoSystem.getPhase(0).getMolarMass;
        nargout(2) = 0;
    end
else
    nargout(2) = thermoSystem.getPhase(0).getMolarMass;
    nargout(3) = thermoSystem.getPhase(1).getMolarMass;
end
nargout(4) = thermoSystem.getNumberOfPhases;