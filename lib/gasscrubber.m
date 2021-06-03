function gasscrubber = gasscrubber(teststream,name)
% Summary description
% function gasscrubber = gasscrubber(teststream,name)
%
% INPUT:
%  - teststream  - Desc
%  - name        - Desc
%
% OUTPUT:
%  - gasscrubber - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% gasscrubber = gasscrubber(teststream,name);

% p specifies the outlet pressure
global processOperations

pathNeqSim();

gasscrubber = neqsim.processSimulation.processEquipment.separator.GasScrubberSimple(teststream);
if nargin > 1
    gasscrubber.setName(name);
end
processOperations.add(gasscrubber);
