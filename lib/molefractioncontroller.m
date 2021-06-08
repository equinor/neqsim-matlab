function molefractioncontroller = molefractioncontroller(stream,name)
% Create controllerDevice molefractioncontroller
% function molefractioncontroller = molefractioncontroller(stream,name)
%
% INPUT:
%  - stream                 - ProcessEquipment stream object
%  - name                   - Name of molefractioncontroller
%
% OUTPUT:
%  - molefractioncontroller - MoleFractionControllerUtil object
%
% DESCRIPTION:
% Create controllerDevice molefractioncontroller
%
% EXAMPLE:
% molefractioncontroller1 = molefractioncontroller(stream1,name);

narginchk(1,2);

global processOperations
pathNeqSim();

molefractioncontroller = neqsim.processSimulation.controllerDevice.MoleFractionControllerUtil(stream);
if nargin > 1
    molefractioncontroller.setName(name);
end
processOperations.add(molefractioncontroller);
