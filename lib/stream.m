function s = stream(thermoSystem,name,t,p)
% Create processEquipment stream
% function stream = stream(thermoSystem,name,t,p)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%
% OPTIONAL INPUT:
%  - name       - Name of stream
%  - t          - Set temperature of thermoSystem
%  - p          - Set pressure of thermoSystem
%
% OUTPUT:
%  - s          - Stream object
%
% DESCRIPTION:
% Create processEquipment stream.
% Streams are used when creating other processEquipment objects
%
% EXAMPLE:
% stream_1 = stream(thermoSystem,name,t,p);

narginchk(1,3);

global processOperations
pathNeqSim();

if nargin > 3
    thermoSystem.setPressure(p);
end
if nargin > 2
    thermoSystem.setTemperature(t);
end

s = neqsim.processSimulation.processEquipment.stream.Stream(thermoSystem);
if nargin > 1
    s.setName(name);
end
processOperations.add(s);