function heatexchanger = heatexchanger(teststream,outTemperature,name)
% Summary description
% function heatexchanger = heatexchanger(teststream,outTemperature,name)
%
% INPUT:
%  - teststream     - Desc
%  - outTemperature - Desc
%  - name           - Desc
%
% OUTPUT:
%  - heatexchanger  - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% heatexchanger = heatexchanger(teststream,outTemperature,name);

global processOperations

pathNeqSim();

heatexchanger = neqsim.processSimulation.processEquipment.heatExchanger.Heater(teststream);
if nargin > 1
    heatexchanger.setOutTemperature(outTemperature)
end
if nargin > 2
    heatexchanger.setName(name);
end
processOperations.add(heatexchanger);
