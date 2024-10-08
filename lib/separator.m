function sep = separator(s,name)
% Create processequipment separator
% function sep = separator(s,name)
%
% INPUT:
%  - s    - processequipment stream object
%  - name - Name of separator
%
% OUTPUT:
%  - sep  - Separator object
%
% DESCRIPTION:
% Create processequipment separator
%
% EXAMPLE:
% sep = separator(stream1,name);

narginchk(2,3);

global processOperations
pathNeqSim();

sep = neqsim.processsimulation.processequipment.separator.ThreePhaseSeparator(name, s);
if nargin > 1
    sep.setName(name);
end
processOperations.add(sep);
