function sep = separator(s,name)
% Create processEquipment separator
% function sep = separator(s,name)
%
% INPUT:
%  - s    - ProcessEquipment stream object
%  - name - Name of separator
%
% OUTPUT:
%  - sep  - Separator object
%
% DESCRIPTION:
% Create processEquipment separator
%
% EXAMPLE:
% sep = separator(stream1,name);

narginchk(2,3);

global processOperations
pathNeqSim();

sep = neqsim.processSimulation.processEquipment.separator.ThreePhaseSeparator(s);
if nargin > 1
    sep.setName(name);
end
processOperations.add(sep);
