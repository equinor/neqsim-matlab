function scrubber = gasscrubber(s,name)
% Create processequipment gasscrubber
% function scrubber = gasscrubber(s,name)
%
% INPUT:
%  - stream   - processequipment stream object
%  - name     - Name of gas scrubber
%
% OUTPUT:
%  - scrubber - GasScrubberSimple object
%
% DESCRIPTION:
% Create processequipment gasscrubber
%
% EXAMPLE:
% scrubber = gasscrubber(stream1,name);

narginchk(1,2);

global processOperations
pathNeqSim();

scrubber = neqsim.process.equipment.separator.GasScrubberSimple(name, s);
if nargin > 1
    scrubber.setName(name);
end
processOperations.add(scrubber);