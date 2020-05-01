function nargout = density(thermoSystem,t,p)
% Calculates the helmholtzenergy for a given thermodyanmic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar helmholtzenergy, gas molar helmholtzenergy, liquid molar helmholtzenergy
% and the number of phases.
%
% Even Solbraa, 2001.
%

if (nargin >= 3)
    thermoSystem.setPressure(p);
end
if (nargin >= 2)
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);
nargout(1) = thermoSystem.getDensity;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        nargout(2) = thermoSystem.getPhase(0).getDensity;
        nargout(3) = 0;
    else
        nargout(3) = thermoSystem.getPhase(0).getDensity;
        nargout(2) = 0;
    end
else
    nargout(2) = thermoSystem.getPhase(0).getDensity;
    nargout(3) = thermoSystem.getPhase(1).getDensity;
end
nargout(4) = thermoSystem.getNumberOfPhases;