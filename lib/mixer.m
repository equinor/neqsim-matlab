function mixer = mixer(name)
% Create processEquipment mixer
% function mixer = mixer(name)
%
% INPUT:
%  - name  - Name of mixer
%
% OUTPUT:
%  - mixer - StaticMixer object
%
% DESCRIPTION:
% Create processEquipment mixer
%
% EXAMPLE:
% mixer = mixer(name);

narginchk(0,1);

global processOperations
pathNeqSim();

mixer = neqsim.processSimulation.processEquipment.mixer.StaticMixer();
if nargin > 0
    mixer.setName(name);
end
processOperations.add(mixer);
