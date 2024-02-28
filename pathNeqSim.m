function pathNeqSim()
% Add neqsim functions and jar to path, initialize processOperations object
% function pathNeqSim()
% Add NeqSim funtions to path, setup database and call resetProcessOperations
%
% DESCRIPTION:
% Add neqsim jar file to dynamic classpath and matlab neqsim lib functions
% to matlab path.
% Initialize processOperations object 

global processOperations

appDataName = 'NeqSimLoaded';
if ~isappdata(0,appDataName) || ~getappdata(0,appDataName)
    baseFol = fileparts(mfilename('fullpath'));
    
    addpath(fullfile(fileparts(mfilename('fullpath')),'lib'));
    
    librarypath = fullfile(baseFol,'ext');

    jarFiles = cellstr(ls(fullfile(librarypath,'*.jar')));
    for k = numel(jarFiles):-1:1
        dynamicJavaPath = javaclasspath('-dynamic');
        currJar = fullfile(librarypath,jarFiles(k));
        if ~isfile(fullfile(librarypath,jarFiles(k)))
            currJar = jarFiles(k);
        end
        if ~any(contains(dynamicJavaPath,currJar))
            javaclasspath(currJar);
        end
    end
    
    % neqsim.util.database.NeqSimDataBase.setDataBaseType("Derby");
    % neqsim.util.database.NeqSimDataBase.setConnectionString("jdbc:derby:classpath:data/neqsimthermodatabase");
    setappdata(0,appDataName,true);
    
    resetProcessOperations();
end

if isempty(processOperations)
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end
