function system = readFluid(ID)
% Summary description
% function system = readFluid(ID)
%
% INPUT:
%  - ID     - Desc
%
% OUTPUT:
%  - system - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% system = readFluid(ID);

pathNeqSim();

system = thermo();
system = system.readObject(ID);
end
