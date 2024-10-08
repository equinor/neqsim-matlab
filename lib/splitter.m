function split = splitter(s,numb,name)
% Create processequipment splitter
% function split = splitter(s,numb,name)
%
% INPUT:
%  - s     - processequipment stream object
%
% OPTIONAL INPUT:
%  - numb  - Number of splits
%  - name  - Name of splitter
%
% OUTPUT:
%  - split - Splitter object
%
% DESCRIPTION:
% Create processequipment splitter
%
% EXAMPLE:
% split = splitter(s,numb,name);

narginchk(1,3);

global processOperations
pathNeqSim();

split = neqsim.processsimulation.processequipment.splitter.Splitter(name, s);
if nargin > 1
    split.setSplitNumber(numb)
end
if nargin > 2
    split.setName(name);
end
processOperations.add(split);