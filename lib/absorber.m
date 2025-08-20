function absorber = absorber(name)
% Create processequipment absorber
% function absorber = absorber(name)
%
% OPTIONAL INPUT:
%  - name     - Name of absorber
%
% OUTPUT:
%  - absorber - SimpleTEGAbsorber object
%
% DESCRIPTION:
% Create processequipment absorber
%
% EXAMPLE:
% absorber_1 = absorber(name);

narginchk(0,1);

global processOperations
pathNeqSim();

absorber = neqsim.process.equipment.absorber.SimpleTEGAbsorber(name);
processOperations.add(absorber);