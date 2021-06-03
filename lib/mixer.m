function mixer = mixer(name)
% Summary description
% function mixer = mixer(name)
%
% INPUT:
%  - name  - Desc
%
% OUTPUT:
%  - mixer - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% mixer = mixer(name);

global processOperations

pathNeqSim();

mixer = neqsim.processSimulation.processEquipment.mixer.StaticMixer;
if nargin > 0
    mixer.setName(name);
end
processOperations.add(mixer);
