function fluid = flash(fluid,flashtype,spec1,spec2,unitspec1,unitspec2)
% Run a flash calculation for a fluid
% function fluid = flash(fluid,flashtype,spec1,spec2,unitspec1,unitspec2)
%
% INPUT:
%  - fluid - A neqsim fluid java object
%  - flashtype - a string defining the type of flash (TP, TV, PH, TS)
%  - spec1 - the value for the first specification (temperature for the TP flash)
%  - spec2 - the value for the seccond specification (pressure for the TP flash)
% - unitspec1 - the unit for the first specification (eg. "C"/"K"/"bar")
% - unitspec2 - the unit for the seccond specification (eg. "C"/"K"/"J/mol")
% OUTPUT:
%  - fluid    - A neqsim fluid java object after running the flash

pathNeqSim();

testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(fluid);
testFlash.flash(flashtype,spec1,spec2,unitspec1,unitspec2);
fluid.initProperties();
clear testFlash;
end