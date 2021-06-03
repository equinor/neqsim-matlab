function molefractioncontroller = molefractioncontroller(teststream,name)
% Summary description
% function molefractioncontroller = molefractioncontroller(teststream,name)
%
% INPUT:
%  - teststream             - Desc
%  - name                   - Desc
%
% OUTPUT:
%  - molefractioncontroller - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% molefractioncontroller = molefractioncontroller(teststream,name);

global processOperations

pathNeqSim();

molefractioncontroller = neqsim.processSimulation.controllerDevice.MoleFractionControllerUtil(teststream);
if nargin > 1
    molefractioncontroller.setName(name);
end
processOperations.add(molefractioncontroller);
