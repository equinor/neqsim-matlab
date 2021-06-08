function compressor = compressor(stream,p,name)
% Create processEquipment compressor
% function compressor = compressor(stream,p,name)
%
% INPUT:
%  - stream     - ProcessEquipment stream object
%  - p          - Outlet pressure of compressor
%
% OPTIONAL INPUT:
%  - name       - Name of compressor
%
% OUTPUT:
%  - compressor - Compressor object
%
% DESCRIPTION:
% Create processEquipment compressor
% 
% EXAMPLE:
% compressor1 = compressor(stream1,p,name)

narginchk(2,3);

global processOperations
pathNeqSim();

compressor = neqsim.processSimulation.processEquipment.compressor.Compressor(stream);
compressor.setOutletPressure(p);
if nargin > 2
    compressor.setName(name);
end
processOperations.add(compressor);