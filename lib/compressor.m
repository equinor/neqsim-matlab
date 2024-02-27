function cmp = compressor(s,p,name)
% Create processEquipment compressor
% function compressor = compressor(s,p,name)
%
% INPUT:
%  - s    - ProcessEquipment stream object
%  - p    - Outlet pressure of compressor
%
% OPTIONAL INPUT:
%  - name - Name of compressor
%
% OUTPUT:
%  - cmp  - Compressor object
%
% DESCRIPTION:
% Create processEquipment compressor
% 
% EXAMPLE:
% cmp = compressor(stream1,p,name)

narginchk(2,3);

global processOperations
pathNeqSim();

cmp = neqsim.processSimulation.processEquipment.compressor.Compressor(s);
cmp.setOutletPressure(p);
if nargin > 2
    cmp.setName(name);
end
processOperations.add(cmp);