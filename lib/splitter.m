function splitter1 = splitter(teststream,numb,name)
global processOperations

pathNeqSim();

splitter1 = neqsim.processSimulation.processEquipment.splitter.Splitter(teststream);
if (nargin >= 2)
    splitter1.setSplitNumber(numb)
end
if (nargin >= 3)
    splitter1.setName(name);
end

processOperations.add(splitter1);