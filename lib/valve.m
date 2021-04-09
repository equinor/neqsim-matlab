function valve = valve(teststream,p,name)
% p specifies the outlet pressure
global processOperations

pathNeqSim();

valve = neqsim.processSimulation.processEquipment.valve.ThrottlingValve(teststream);
valve.setOutletPressure(p);
if nargin > 2
    valve.setName(name);
end
processOperations.add(valve);