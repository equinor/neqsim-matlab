pathstring = 'C:\Users\esol\OneDrive - Equinor\programming\neqsimmatlab\';

addpath(strcat(pathstring));
addpath(strcat(pathstring, 'example'));
addpath(strcat(pathstring, 'lib'));
librarypath = strcat(pathstring, 'ext\');
databasepath = strcat(pathstring, 'database\');

cellarraywithpaths=({});

if(isempty(javaclasspath))
    jarFiles=ls([librarypath '*.jar']);
        for i = 1:length(jarFiles(:,1))
            cellarraywithpaths{end+1}=[librarypath jarFiles(i,:)];
        end
    javaclasspath(cellarraywithpaths);
end

neqsim.util.database.NeqSimDataBase.setDataBaseType("Derby");
neqsim.util.database.NeqSimDataBase.setConnectionString("jdbc:derby:classpath:data/neqsimthermodatabase");

if ~exist('processOperations')
    global processOperations
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end % end added
