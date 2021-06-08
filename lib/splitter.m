function splitter1 = splitter(stream,numb,name)
% Create processEquipment splitter
% function splitter1 = splitter(stream,numb,name)
%
% INPUT:
%  - stream - ProcessEquipment stream object
%
% OPTIONAL INPUT:
%  - numb       - Desc
%  - name       - Desc
%
% OUTPUT:
%  - splitter1  - Desc
%
% DESCRIPTION:
% Create processEquipment splitter
%
% EXAMPLE:
% splitter1 = splitter(stream,numb,name);

global processOperations
pathNeqSim();

splitter1 = neqsim.processSimulation.processEquipment.splitter.Splitter(stream);
if nargin > 1
    splitter1.setSplitNumber(numb)
end
if nargin > 2
    splitter1.setName(name);
end

processOperations.add(splitter1);