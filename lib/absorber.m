function absorber = absorber(name);
global processOperations
 absorber = neqsim.processSimulation.processEquipment.absorber.SimpleTEGAbsorber();
 if(nargin>=1)
     absorber.setName(name);
 end
 processOperations.add(absorber);
 absorber;