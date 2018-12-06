import neqsim.thermo.*;
import neqsim.thermo.system.*;
import neqsim.PVTsimulation.simulation.*;
import neqsim.thermodynamicOperations.*;
import neqsim.processSimulation.measurementDevice.*;
import neqsim.processSimulation.controllerDevice.*;
import neqsim.processSimulation.processSystem.*;
import neqsim.processSimulation.processEquipment.separator.*;
import neqsim.processSimulation.processEquipment.*;
import neqsim.processSimulation.processEquipment.mixer.*;
import neqsim.processSimulation.processEquipment.stream.*;
import neqsim.processSimulation.processEquipment.heatExchanger.*;
import neqsim.processSimulation.processEquipment.compressor.*;
import neqsim.processSimulation.processEquipment.valve.*;
import neqsim.processSimulation.processEquipment.splitter.*;
import neqsim.processSimulation.processEquipment.absorber.*;
import neqsim.processSimulation.processEquipment.absorber.*;
import neqsim.processSimulation.processEquipment.util.*;

if ~exist('processOperations') % added Even 10/12/2011
    global processOperations
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end