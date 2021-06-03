function separator = separator(teststream,name)
% Create processEquipment separator
% function separator = separator(teststream,name)
%
% INPUT:
%  - teststream - Desc
%  - name       - Desc
%
% OUTPUT:
%  - separator  - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% separator = separator(teststream,name);

global processOperations

pathNeqSim();

separator = neqsim.processSimulation.processEquipment.separator.ThreePhaseSeparator(teststream);
if nargin > 1
    separator.setName(name);
end
processOperations.add(separator);
