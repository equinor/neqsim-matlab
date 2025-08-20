function mixer = mixer(name)
% Create processequipment mixer
% function mixer = mixer(name)
%
% INPUT:
%  - name  - Name of mixer
%
% OUTPUT:
%  - mixer - StaticMixer object
%
% DESCRIPTION:
% Create processequipment mixer
%
% EXAMPLE:
% mixer = mixer(name);

narginchk(0,1);

global processOperations
pathNeqSim();

mixer = neqsim.process.equipment.mixer.StaticMixer(name);
if nargin > 0
    mixer.setName(name);
end
processOperations.add(mixer);
