function nargout = molefrac(thermoSystem,i,t,p)
% Calculates the molefraction of component i in a phase for a given thermodyanmic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is number of moles in phase, gas number of moles in phase, liquid number of moles in phase
% and the number of phases.
%
% Even Solbraa, 2001.
%
if (nargin >= 4)
    thermoSystem.setPressure(p);
end
if (nargin >= 3)
    thermoSystem.setTemperature(t);
    TPflash(thermoSystem,0);
end
thermoSystem.init(2);
nargout(1) = thermoSystem.getPhase(0).getComponent(i).getz;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        nargout(2) = thermoSystem.getPhase(0).getComponent(i).getx;
        nargout(3) = 0;
    else
        nargout(3) = thermoSystem.getPhase(0).getComponent(i).getx;
        nargout(2) = 0;
    end
else
    nargout(2) = thermoSystem.getPhase(0).getComponent(i).getx;
    nargout(3) = thermoSystem.getPhase(1).getComponent(i).getx;
end
nargout(4) = thermoSystem.getNumberOfPhases;