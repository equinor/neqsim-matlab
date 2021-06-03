function absorber = absorber(name)
% Summary description
% function absorber = absorber(name)
%
% OPTIONAL INPUT:
%  - name     - Desc
%
% OUTPUT:
%  - absorber - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% absorber = absorber(name);

global processOperations
pathNeqSim();

absorber = neqsim.processSimulation.processEquipment.absorber.SimpleTEGAbsorber();
if nargin > 0
    absorber.setName(name);
end
processOperations.add(absorber);
