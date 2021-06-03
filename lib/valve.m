function valve = valve(teststream,p,name)
% Summary description
% function valve = valve(teststream,p,name)
%
% INPUT:
%  - teststream - Desc
%  - p          - Valve outlet pressure
%
% OPTIONAL INPUT:
%  - name       - Desc
%
% OUTPUT:
%  - valve      - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% valve = valve(teststream,p,name);

narginchk(2,3);

global processOperations

pathNeqSim();

valve = neqsim.processSimulation.processEquipment.valve.ThrottlingValve(teststream);
valve.setOutletPressure(p);
if nargin > 2
    valve.setName(name);
end
processOperations.add(valve);