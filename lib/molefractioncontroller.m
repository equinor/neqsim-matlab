function mfc = molefractioncontroller(s,name)
% Create controllerDevice molefractioncontroller
% function molefractioncontroller = molefractioncontroller(s,name)
%
% INPUT:
%  - s    - ProcessEquipment stream object
%  - name - Name of molefractioncontroller
%
% OUTPUT:
%  - mfc  - MoleFractionControllerUtil object
%
% DESCRIPTION:
% Create controllerDevice molefractioncontroller
%
% EXAMPLE:
% molefractioncontroller1 = molefractioncontroller(stream1,name);

narginchk(1,2);

global processOperations
pathNeqSim();

mfc = neqsim.processSimulation.controllerDevice.MoleFractionControllerUtil(s);
if nargin > 1
    mfc.setName(name);
end
processOperations.add(mfc);
