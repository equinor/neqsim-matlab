function gasscrubber = gasscrubber(stream,name)
% Create processEquipment gasscrubber
% function gasscrubber = gasscrubber(stream,name)
%
% INPUT:
%  - stream - ProcessEquipment stream object
%  - name        - Desc
%
% OUTPUT:
%  - gasscrubber - Desc
%
% DESCRIPTION:
% Create processEquipment gasscrubber
%
% EXAMPLE:
% gasscrubber1 = gasscrubber(teststream,name);
narginchk(1,2);

global processOperations
pathNeqSim();

gasscrubber = neqsim.processSimulation.processEquipment.separator.GasScrubberSimple(stream);
if nargin > 1
    gasscrubber.setName(name);
end

processOperations.add(gasscrubber);