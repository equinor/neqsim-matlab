function v = valve(s,p,name)
% Create processEquipment ThrottlingValve
% function v = valve(s,p,name)
%
% INPUT:
%  - s     - ProcessEquipment stream object
%  - p     - Valve outlet pressure
%
% OPTIONAL INPUT:
%  - name  - Name of valve
%
% OUTPUT:
%  - valve - ThrottlingValve object
%
% DESCRIPTION:
% Create processEquipment ThrottlingValve
%
% EXAMPLE:
% valve1 = valve(s,p,name);

narginchk(2,3);

global processOperations
pathNeqSim();

v = neqsim.processSimulation.processEquipment.valve.ThrottlingValve(s);
v.setOutletPressure(p);
if nargin > 2
    v.setName(name);
end
processOperations.add(v);