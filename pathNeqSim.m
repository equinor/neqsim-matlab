function pathNeqSim(baseFol)
% Add NeqSim funtions to path, setup database and call resetProcessOperations
% function pathNeqSim(baseFol)
%
% OPTIONAL INPUT:
%  - baseFol - Overwrite Neqsim base folder.
%
% DESCRIPTION:
% Add NeqSim jar to path, setup database and call resetProcessOperations

appDataName = 'NeqSimLoaded';
if ~isappdata(0,appDataName) || ~getappdata(0,appDataName)
    if ~exist('baseFol','var') || isempty(baseFol)
        baseFol = fileparts(mfilename('fullpath'));
    elseif ~isfolder(baseFol)
        error('Input baseFol does not exist');
    end
    addpath(baseFol);
    addpath(fullfile(baseFol,'lib'));
    
    librarypath = fullfile(baseFol,'ext');
    
    jarFiles = cellstr(ls(fullfile(librarypath,'*.jar')));
    for k = numel(jarFiles):-1:1
        dynamicJavaPath = javaclasspath('-dynamic');
        currJar = fullfile(librarypath,jarFiles(k));
        if ~any(contains(dynamicJavaPath,currJar))
            javaclasspath(currJar);
        end
    end
    
    neqsim.util.database.NeqSimDataBase.setDataBaseType("Derby");
    neqsim.util.database.NeqSimDataBase.setConnectionString("jdbc:derby:classpath:data/neqsimthermodatabase");
    setappdata(0,appDataName,true);
    
    resetProcessOperations();
end