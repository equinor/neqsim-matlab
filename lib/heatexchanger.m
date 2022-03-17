function he = heatexchanger(stream,outTemperature,name)
% Create Process Equipment Heat Exchanger
% function heatexchanger = heatexchanger(stream,outTemperature,name)
%
% INPUT:
%  - stream         - ProcessEquipment stream object
%  - outTemperature - Outlet temperature of heat exchanger
%  - name           - Name of heatexchanger
%
% OUTPUT:
%  - heatexchanger  - HeatExchanger object
%
% DESCRIPTION:
% Create Process Equipment Heat Exchanger
%
% EXAMPLE:
% heatexchanger1 = heatexchanger(teststream,outTemperature,name);

narginchk(1,3);

global processOperations
pathNeqSim();

he = neqsim.processSimulation.processEquipment.heatExchanger.Heater(stream);
if nargin > 1
    he.setOutTemperature(outTemperature)
end
if nargin > 2
    he.setName(name);
end
processOperations.add(he);
