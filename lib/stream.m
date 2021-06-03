function stream = stream(thermoSystem,name,t,p)
% Create processEquipment stream
% function stream = stream(thermoSystem,name,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system
%
% OPTIONAL INPUT:
%  - name       - Desc
%  - t          - Desc
%  - p          - Desc
%
% OUTPUT:
%  - stream     - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% stream = stream(thermoSystem,name,t,p);

narginchk(1,3);

global processOperations

pathNeqSim();
if nargin > 3
    thermoSystem.setPressure(p);
end
if nargin > 2
    thermoSystem.setTemperature(t);
end
stream = neqsim.processSimulation.processEquipment.stream.Stream(thermoSystem);
if nargin > 1
    stream.setName(name);
end
processOperations.add(stream);