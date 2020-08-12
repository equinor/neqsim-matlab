function pathNeqSim(baseFol)
%
% function pathNeqSim(baseFol)
%
% OPTIONAL INPUT:
%  - baseFol
%
% DESCRIPTION:
%

appDataName = 'NeqSimLoaded';
if ~isappdata(0,appDataName) || ~getappdata(0,appDataName)
    if ~exist('baseFol','var') || isempty(baseFol)
        baseFol = fileparts(mfilename('fullpath'));
    elseif ~isfolder(baseFol)
        error('Input baseFol does not exist');
    end
    addpath(baseFol);
    addpath(fullfile(baseFol,'example'));
    addpath(fullfile(baseFol,'lib'));
    
    librarypath = fullfile(baseFol,'ext');
    % databasepath = fullfile(baseFol, 'database');
    
    jarFiles = cellstr(ls(fullfile(librarypath,'*.jar')));
    for k = numel(jarFiles):-1:1
        dynamicJavaPath = javaclasspath('-dynamic');
        currJar = fullfile(librarypath,jarFiles(k));
        if ~any(contains(dynamicJavaPath,currJar))
            javaclasspath(currJar);
        end
    end
    
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
    
    neqsim.util.database.NeqSimDataBase.setDataBaseType("Derby");
    neqsim.util.database.NeqSimDataBase.setConnectionString("jdbc:derby:classpath:data/neqsimthermodatabase");
    
    resetProcessOperations();
    
    setappdata(0,appDataName,true);
end