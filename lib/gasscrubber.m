function gasscrubber = gasscrubber(stream,name)
% Create processEquipment gasscrubber
% function gasscrubber = gasscrubber(stream,name)
%
% INPUT:
%  - stream      - ProcessEquipment stream object
%  - name        - Name of gas scrubber
%
% OUTPUT:
%  - gasscrubber - GasScrubberSimple object
%
% DESCRIPTION:
% Create processEquipment gasscrubber
%
% EXAMPLE:
% gasscrubber1 = gasscrubber(stream1,name);

narginchk(1,2);

global processOperations
pathNeqSim();

gasscrubber = neqsim.processSimulation.processEquipment.separator.GasScrubberSimple(stream);
if nargin > 1
    gasscrubber.setName(name);
end
processOperations.add(gasscrubber);