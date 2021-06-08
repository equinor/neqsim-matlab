function splitter = splitter(stream,numb,name)
% Create processEquipment splitter
% function splitter = splitter(stream,numb,name)
%
% INPUT:
%  - stream - ProcessEquipment stream object
%
% OPTIONAL INPUT:
%  - numb       - Number of splits
%  - name       - Name of splitter
%
% OUTPUT:
%  - splitter  - Splitter object
%
% DESCRIPTION:
% Create processEquipment splitter
%
% EXAMPLE:
% splitter1 = splitter(stream1,numb,name);

narginchk(1,3);

global processOperations
pathNeqSim();

splitter = neqsim.processSimulation.processEquipment.splitter.Splitter(stream);
if nargin > 1
    splitter.setSplitNumber(numb)
end
if nargin > 2
    splitter.setName(name);
end
processOperations.add(splitter);