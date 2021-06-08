function separator = separator(stream,name)
% Create processEquipment separator
% function separator = separator(stream,name)
%
% INPUT:
%  - stream - ProcessEquipment stream object
%  - name       - Desc
%
% OUTPUT:
%  - separator  - Desc
%
% DESCRIPTION:
% Create processEquipment separator
%
% EXAMPLE:
% separator1 = separator(stream1,name);

narginchk(2,3);

global processOperations
pathNeqSim();

separator = neqsim.processSimulation.processEquipment.separator.ThreePhaseSeparator(stream);
if nargin > 1
    separator.setName(name);
end
processOperations.add(separator);
