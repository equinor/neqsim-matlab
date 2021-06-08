function heatexchanger = heatexchanger(stream,outTemperature,name)
% Summary description
% function heatexchanger = heatexchanger(stream,outTemperature,name)
%
% INPUT:
%  - stream - ProcessEquipment stream object
%  - outTemperature - Outlet temperature of heat exchanger
%  - name           - Name of heatexchanger
%
% OUTPUT:
%  - heatexchanger  - HeatExchanger object
%
% DESCRIPTION:
%
%
% EXAMPLE:
% heatexchanger1 = heatexchanger(teststream,outTemperature,name);

narginchk(1,3);

global processOperations
pathNeqSim();

heatexchanger = neqsim.processSimulation.processEquipment.heatExchanger.Heater(stream);
if nargin > 1
    heatexchanger.setOutTemperature(outTemperature)
end
if nargin > 2
    heatexchanger.setName(name);
end
processOperations.add(heatexchanger);
