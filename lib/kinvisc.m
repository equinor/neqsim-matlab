function S = kinvisc(thermoSystem,t,p)
% Summary description
% function S = kinvisc(thermoSystem,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - t            - Desc
%  - p            - Desc
%
% OUTPUT:
%  - S      - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% nargout = kinvisc(thermoSystem,t,p);

% Calculates the kinematic viscosity for a given thermodynamic system
% If temperature or pressure are specified - a TP flash is done.
% The output is total molar kinematic viscosity, gas molar helmholtzenergy, liquid molar helmholtzenergy
% and the number of phases.
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
thermoSystem.initPhysicalProperties;
S(1) = thermoSystem.getKinematicViscosity;
if (thermoSystem.getNumberOfPhases == 1)
    if (thermoSystem.getPhase(0).getPhaseType == 1)
        S(2) = thermoSystem.getPhase(0).getPhysicalProperties.getKinematicViscosity;
        S(3) = 0;
    else
        S(3) = thermoSystem.getPhase(0).getPhysicalProperties.getKinematicViscosity;
        S(2) = 0;
    end
else
    S(2) = thermoSystem.getPhase(0).getPhysicalProperties.getKinematicViscosity;
    S(3) = thermoSystem.getPhase(1).getPhysicalProperties.getKinematicViscosity;
end
S(4) = thermoSystem.getNumberOfPhases();
