function fluid = fluid(definedcomponents,oilcomponents)
% Create NEQsim Fluid object
% function fluid = fluid(definedcomponents,oilcomponents)
%
% INPUT:
%  - definedcomponents - Array of struct with 
%  - oilcomponents     - Desc
%
% OUTPUT:
%  - fluid             - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% fluid = fluid(definedcomponents,oilcomponents);

pathNeqSim();

unit = 'mole/sec';
fluidClass = neqsim.thermo.Fluid();
fluid = fluidClass.create2(definedcomponents.names,definedcomponents.composition,unit);

if nargin > 1
    fluid = fluidClass.addOilFractions(oilcomponents.names,oilcomponents.composition,oilcomponents.molarmass,oilcomponents.relativedensity,oilcomponents.plusfraction);
end