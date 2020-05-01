function stream = stream(testSystem,name,t,p)
global processOperations
if (nargin >= 4)
    testSystem.setPressure(p);
end
if (nargin >= 3)
    testSystem.setTemperature(t);
end
stream = neqsim.processSimulation.processEquipment.stream.Stream(testSystem);
if (nargin >= 2)
    stream.setName(name);
end
processOperations.add(stream);
stream;