function valve = valve(stream,p,name)
% Create 
% function valve = valve(stream,p,name)
%
% INPUT:
%  - stream - ProcessEquipment stream object
%  - p      - Valve outlet pressure
%
% OPTIONAL INPUT:
%  - name   - Desc
%
% OUTPUT:
%  - valve  - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% valve1 = valve(stream1,p,name);

narginchk(2,3);

global processOperations
pathNeqSim();

valve = neqsim.processSimulation.processEquipment.valve.ThrottlingValve(stream);
valve.setOutletPressure(p);
if nargin > 2
    valve.setName(name);
end
processOperations.add(valve);