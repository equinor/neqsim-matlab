function nargout = moles(thermoSystem, t, p)
% Calculates the number of moles in phase for a given thermodyanmic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is number of moles in phase, gas number of moles in phase, liquid number of moles in phase
% and the number of phases.
%
% Even Solbraa, 2001.
%

 if(nargin>=3)
     thermoSystem.setPressure(p);
 end
 if(nargin>=2)
     thermoSystem.setTemperature(t);
     TPflash(thermoSystem, 0);
 end
 thermoSystem.init(2);
 nargout(1) = thermoSystem.getNumberOfMoles;
 if(thermoSystem.getNumberOfPhases==1)
     if(thermoSystem.getPhase(0).getPhaseType==1)
         nargout(2) = thermoSystem.getPhase(0).getNumberOfMolesInPhase;
         nargout(3) = 0;
     else
        nargout(3) = thermoSystem.getPhase(0).getNumberOfMolesInPhase;
        nargout(2) = 0;
    end
else
    nargout(2) = thermoSystem.getPhase(0).getNumberOfMolesInPhase;
    nargout(3) = thermoSystem.getPhase(1).getNumberOfMolesInPhase;
end
nargout(4)=thermoSystem.getNumberOfPhases;