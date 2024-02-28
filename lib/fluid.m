function f = fluid(definedcomponents,oilcomponents)
% Create NEQsim Fluid object
% function f = fluid(definedcomponents,oilcomponents)
%
% INPUT:
%  - definedcomponents - Array of struct with 
%  - oilcomponents     - Desc
%
% OUTPUT:
%  - f                 - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% fluid = fluid(definedcomponents,oilcomponents);

pathNeqSim();

unit = 'mole/sec';
fluidClass = neqsim.thermo.Fluid();
f = fluidClass.create2(definedcomponents.names,definedcomponents.composition,unit);

if nargin > 1
    f = fluidClass.addOilFractions(oilcomponents.names,oilcomponents.composition,oilcomponents.molarmass,oilcomponents.relativedensity,oilcomponents.plusfraction);
end