function gasscrubber = gasscrubber(teststream,name);
% p specifies the outlet pressure
global processOperations
gasscrubber = neqsim.processSimulation.processEquipment.separator.GasScrubberSimple(teststream);
if (nargin >= 2)
    gasscrubber.setName(name);
end
processOperations.add(gasscrubber);