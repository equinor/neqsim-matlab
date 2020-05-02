function valve = valve(teststream,p,name);
% p specifies the outlet pressure
global processOperations
valve = neqsim.processSimulation.processEquipment.valve.ThrottlingValve(teststream);
valve.setOutletPressure(p);
if (nargin >= 3)
    valve.setName(name);
end
processOperations.add(valve);