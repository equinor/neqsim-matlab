function p = addfluids(fluid1,fluid2)
% Summary description
% function p = addfluids(fluid1,fluid2)
%
% INPUT:
%  - fluid1 - Desc
%  - fluid2 - Desc
%
% OUTPUT:
%  - p      - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% p = addfluids(fluid1,fluid2);

pathNeqSim();

p = neqsim.thermo.system.SystemInterface.addFluids(fluid1,fluid2);
