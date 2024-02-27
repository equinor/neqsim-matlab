function he = heatexchanger(s,outTemperature,name)
% Create Process Equipment Heat Exchanger
% function he = heatexchanger(s,outTemperature,name)
%
% INPUT:
%  - s              - ProcessEquipment stream object
%  - outTemperature - Outlet temperature of heat exchanger
%  - name           - Name of heatexchanger
%
% OUTPUT:
%  - he            - HeatExchanger object
%
% DESCRIPTION:
% Create Process Equipment Heat Exchanger
%
% EXAMPLE:
% he = heatexchanger(teststream,outTemperature,name);

narginchk(1,3);

global processOperations
pathNeqSim();

he = neqsim.processSimulation.processEquipment.heatExchanger.Heater(s);
if nargin > 1
    he.setOutTemperature(outTemperature)
end
if nargin > 2
    he.setName(name);
end
processOperations.add(he);
