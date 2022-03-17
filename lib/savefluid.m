function savefluid(thermoSystem,filepath)
% Save thermoSystem to file
% function  = savefluid(thermoSystem,filepath)
%
% INPUT:
%  - thermoSystem - Thermodynamic system object
%  - filepath     - Filepath to store fluid at
%
% DESCRIPTION:
% Save thermoSystem to file
%
% EXAMPLE:
% savefluid(thermoSystem,filepath);

thermoSystem.saveObjectToFile(filepath,"")