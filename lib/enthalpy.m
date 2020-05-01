function nargout = enthalpy(thermoSystem,t,p)
% Calculates the enthalpy for a given thermodyanmic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar enthalpy, gas molar enthalpy, liquid molar enthalpy
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
thermoSystem.init(3);
nargout(1) = thermoSystem.getEnthalpy/thermoSystem.getNumberOfMoles;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        nargout(2) = thermoSystem.getPhase(0).getEnthalpy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        nargout(3) = 0;
    else
        nargout(3) = thermoSystem.getPhase(0).getEnthalpy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        nargout(2) = 0;
    end
else
    nargout(2) = thermoSystem.getPhase(0).getEnthalpy/thermoSystem.getPhase(0).getNumberOfMolesInPhase;
    nargout(3) = thermoSystem.getPhase(1).getEnthalpy/thermoSystem.getPhase(1).getNumberOfMolesInPhase;
end
nargout(4) = thermoSystem.getNumberOfPhases;