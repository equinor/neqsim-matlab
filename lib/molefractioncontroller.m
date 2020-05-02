function molefractioncontroller = molefractioncontroller(teststream,name);
global processOperations
molefractioncontroller = neqsim.processSimulation.controllerDevice.MoleFractionControllerUtil(teststream);
if (nargin >= 2)
    molefractioncontroller.setName(name);
end
processOperations.add(molefractioncontroller);
molefractioncontroller;