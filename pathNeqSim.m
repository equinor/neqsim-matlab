pathstring = 'C:\Users\esol\OneDrive - Statoil ASA\programming\neqsimmatlab\';

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

neqsim.util.database.NeqSimDataBase.setDataBaseType("mySQL");
neqsim.util.database.NeqSimDataBase.setConnectionString("jdbc:mysql://tr-w33:3306/neqsimthermodatabase");

%neqsim.util.database.NeqSimDataBase.setDataBaseType("mySQLNTNU");
neqsim.util.database.NeqSimDataBase.setConnectionString("jdbc:mysql://tr-w33:3306/neqsimthermodatabase");

%neqsim.util.database.NeqSimDataBase.setDataBaseType("MSAccessUCanAccess");
%NeqSimDataBase.dataBasePathMSAccess = strcat(databasepath, 'NeqSimDatabase.mdb');

if ~exist('processOperations')
    global processOperations
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end % end added
