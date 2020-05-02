function compressor = compressor(teststream,p,name);
% p specifies the outlet pressure
global processOperations
compressor = neqsim.processSimulation.processEquipment.compressor.Compressor(teststream);
compressor.setOutletPressure(p);
if (nargin >= 3)
    compressor.setName(name);
end
processOperations.add(compressor);