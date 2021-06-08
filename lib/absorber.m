function absorber = absorber(name)
% Create processEquipment absorber
% function absorber = absorber(name)
%
% OPTIONAL INPUT:
%  - name     - Desc
%
% OUTPUT:
%  - absorber - Desc
%
% DESCRIPTION:
% Create processEquipment absorber
%
% EXAMPLE:
% absorber_1 = absorber(name);

global processOperations
pathNeqSim();

absorber = neqsim.processSimulation.processEquipment.absorber.SimpleTEGAbsorber();
if nargin > 0
    absorber.setName(name);
end
processOperations.add(absorber);