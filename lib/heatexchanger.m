function heatexchanger = heatexchanger(teststream, outTemperature, name);
% p specifies the outlet pressure
global processOperations
 heatexchanger = neqsim.processSimulation.processEquipment.heatExchanger.Heater(teststream);
 if(nargin>=2)
     heatexchanger.setOutTemperature(outTemperature)
 end
 if(nargin>=3)
     heatexchanger.setName(name);
 end
 processOperations.add(heatexchanger);

   