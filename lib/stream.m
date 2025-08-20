function s = stream(thermoSystem,name,t,p)
% Create processequipment stream
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
% Create processequipment stream.
% Streams are used when creating other processequipment objects
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

s = neqsim.process.equipment.stream.Stream("", thermoSystem);
if nargin > 1
    s.setName(name);
end
processOperations.add(s);