function absorber = absorber(name)
global processOperations
pathNeqSim();

absorber = neqsim.processSimulation.processEquipment.absorber.SimpleTEGAbsorber();
if (nargin >= 1)
    absorber.setName(name);
end
processOperations.add(absorber);