function molefractioncontroller = molefractioncontroller(stream,name)
% Summary description
% function molefractioncontroller = molefractioncontroller(stream,name)
%
% INPUT:
%  - stream - ProcessEquipment stream object
%  - name                   - Desc
%
% OUTPUT:
%  - molefractioncontroller - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% molefractioncontroller1 = molefractioncontroller(teststream,name);
narginchk(1,2);

global processOperations
pathNeqSim();

molefractioncontroller = neqsim.processSimulation.controllerDevice.MoleFractionControllerUtil(stream);
if nargin > 1
    molefractioncontroller.setName(name);
end
processOperations.add(molefractioncontroller);
