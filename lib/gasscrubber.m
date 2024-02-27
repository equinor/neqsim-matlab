function scrubber = gasscrubber(s,name)
% Create processEquipment gasscrubber
% function scrubber = gasscrubber(s,name)
%
% INPUT:
%  - stream   - ProcessEquipment stream object
%  - name     - Name of gas scrubber
%
% OUTPUT:
%  - scrubber - GasScrubberSimple object
%
% DESCRIPTION:
% Create processEquipment gasscrubber
%
% EXAMPLE:
% scrubber = gasscrubber(stream1,name);

narginchk(1,2);

global processOperations
pathNeqSim();

scrubber = neqsim.processSimulation.processEquipment.separator.GasScrubberSimple(s);
if nargin > 1
    scrubber.setName(name);
end
processOperations.add(scrubber);