function v = valve(s,p,name)
% Create processequipment ThrottlingValve
% function v = valve(s,p,name)
%
% INPUT:
%  - s     - processequipment stream object
%  - p     - Valve outlet pressure
%
% OPTIONAL INPUT:
%  - name  - Name of valve
%
% OUTPUT:
%  - valve - ThrottlingValve object
%
% DESCRIPTION:
% Create processequipment ThrottlingValve
%
% EXAMPLE:
% valve1 = valve(s,p,name);

narginchk(2,3);

global processOperations
pathNeqSim();

v = neqsim.processsimulation.processequipment.valve.ThrottlingValve(name, s);
v.setOutletPressure(p);
if nargin > 2
    v.setName(name);
end
processOperations.add(v);