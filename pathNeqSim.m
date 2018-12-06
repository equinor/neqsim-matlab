pathToJavaJar = 'C:\app\neqsimMatlab\ext\';
pathstring = 'C:\app\neqsimMatlab\';

addpath(strcat(pathstring));
addpath(strcat(pathstring, 'example'));
addpath(strcat(pathstring, 'lib'));

tempClassPath = javaclasspath;
if isempty(tempClassPath)
    cellarraywithpaths=({});
    rootpath = pathToJavaJar;
    a=ls([rootpath '*.jar']);
    for i = 1:length(a(:,:))
        cellarraywithpaths{end+1}=[rootpath a(i,:)];
    end
    javaclasspath(cellarraywithpaths);
end
neqsim.util.database.NeqSimDataBase.setDataBaseType("MSAccessUCanAccess");
%neqsim.util.database.NeqSimDataBase.setDataBaseType("MSAccessUCanAccess");
%alternative use mysql database (if NeqSim MySql database available on network)
%NeqSimDataBase.dataBaseType = 'mySQL'; 
NeqSimDataBase.dataBasePathMSAccess = 'C:/programming/NeqSimSourceCode/java/neqsim/data/NeqSimDatabase.mdb';

if ~exist('processOperations')
    global processOperations
    processOperations = neqsim.processSimulation.processSystem.ProcessSystem;
end % end added

