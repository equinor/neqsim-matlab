function absorber = absorber(name)
% Create processEquipment absorber
% function absorber = absorber(name)
%
% OPTIONAL INPUT:
%  - name     - Name of absorber
%
% OUTPUT:
%  - absorber - SimpleTEGAbsorber object
%
% DESCRIPTION:
% Create processEquipment absorber
%
% EXAMPLE:
% absorber_1 = absorber(name);

narginchk(0,1);

global processOperations
pathNeqSim();

absorber = neqsim.processSimulation.processEquipment.absorber.SimpleTEGAbsorber();
if nargin > 0
    absorber.setName(name);
end
processOperations.add(absorber);