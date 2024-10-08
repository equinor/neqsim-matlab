function f = flash(f,flashtype,spec1,spec2,unitspec1,unitspec2)
% Run a flash calculation for a fluid
% function f = flash(f,flashtype,spec1,spec2,unitspec1,unitspec2)
%
% INPUT:
%  - f         - a neqsim fluid java object
%  - flashtype - a string defining the type of flash (TP, TV, PH, TS)
%  - spec1     - the value for the first specification (temperature for the TP flash)
%  - spec2     - the value for the seccond specification (pressure for the TP flash)
%  - unitspec1 - the unit for the first specification (eg. "C"/"K"/"bar")
%  - unitspec2 - the unit for the seccond specification (eg. "C"/"K"/"J/mol")
%
% OUTPUT:
%  - fluid     - A neqsim fluid java object after running the flash
%
% DESCRIPTION:
% Run a flash calculation for a fluid
%
% EXAMPLE:
% fluid = flash(fluid,flashtype,spec1,spec2,unitspec1,unitspec2);

narginchk(6,6);

pathNeqSim();

testFlash = neqsim.thermodynamicoperations.ThermodynamicOperations(f);
testFlash.flash(flashtype,spec1,spec2,unitspec1,unitspec2);
f.initProperties();