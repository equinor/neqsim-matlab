function savefluid(thermoSystem,filepath)
% Save to file
% function  = savefluid(thermoSystem,filepath)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%  - filepath     - Filepath to store fluid at
%
% DESCRIPTION:
%
%
% EXAMPLE:
%  = savefluid(thermoSystem,filepath);

thermoSystem.saveObjectToFile(filepath,"")
