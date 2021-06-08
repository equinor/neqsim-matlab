function components = componentNames()
% Get all components available in database
% function components = componentNames()
%
% OUTPUT:
%  - components - Cell string array of components in database
%
% DESCRIPTION:
% Get all components available in database

narginchk(0,0);

pathNeqSim();

% neqsim.util.database.NeqSimDataBase.NeqSimDataBase();
components = cellstr(neqsim.util.database.NeqSimDataBase.getComponentNames());