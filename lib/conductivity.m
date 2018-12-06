function nargout = conductivity(thermoSystem, t, p)
% Calculates the conductivity for a given thermodyanmic system
% If temperature or pressure are specified - a TP flash is done.
% The output is total molar conductivity, gas conductivity, liquid conductivity
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
 thermoSystem.initPhysicalProperties;
 nargout(1) = thermoSystem.getConductivity;
 if(thermoSystem.getNumberOfPhases==1)
     if(thermoSystem.getPhase(0).getPhaseType==1)
         nargout(2) = thermoSystem.getPhase(0).getPhysicalProperties.getConductivity;
         nargout(3) = 0;
     else
        nargout(3) = thermoSystem.getPhase(0).getPhysicalProperties.getConductivity;
        nargout(2) = 0;
    end
else
    nargout(2) = thermoSystem.getPhase(0).getPhysicalProperties.getConductivity;
    nargout(3) = thermoSystem.getPhase(1).getPhysicalProperties.getConductivity;
end
nargout(4)=thermoSystem.getNumberOfPhases;
