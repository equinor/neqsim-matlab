function splitter1 = splitter(teststream,numb,name)
% Create processEquipment splitter
% function splitter1 = splitter(teststream,numb,name)
%
% INPUT:
%  - teststream - Desc
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
% splitter1 = splitter(teststream,numb,name);

global processOperations

pathNeqSim();

splitter1 = neqsim.processSimulation.processEquipment.splitter.Splitter(teststream);
if nargin > 1
    splitter1.setSplitNumber(numb)
end
if nargin > 2
    splitter1.setName(name);
end

processOperations.add(splitter1);
