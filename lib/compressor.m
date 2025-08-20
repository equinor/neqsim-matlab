function cmp = compressor(s,p,name)
% Create processequipment compressor
% function compressor = compressor(s,p,name)
%
% INPUT:
%  - s    - processequipment stream object
%  - p    - Outlet pressure of compressor
%
% OPTIONAL INPUT:
%  - name - Name of compressor
%
% OUTPUT:
%  - cmp  - Compressor object
%
% DESCRIPTION:
% Create processequipment compressor
%
% EXAMPLE:
% cmp = compressor(stream1,p,name)

narginchk(2,3);

global processOperations
pathNeqSim();

cmp = neqsim.process.equipment.compressor.Compressor(name, s);
cmp.setOutletPressure(p);
if nargin > 2
    cmp.setName(name);
end
processOperations.add(cmp);