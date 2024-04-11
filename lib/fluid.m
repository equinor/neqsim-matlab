function f = fluid(definedcomponents,oilcomponents,unit)
% Create NEQsim Fluid object
% function f = fluid(definedcomponents,oilcomponents,unit)
%
% INPUT:
%  - definedcomponents - struct with names and composition fractions.
%
% OPTIONAL INPUT:
%  - oilcomponents     - struct with names, compositions, molarmass, relativedensity, plusfraction
%  - unit              - Defaults to 'mole/sec'.
%
% OUTPUT:
%  - f                 - NEQsim fluid object.
%
% DESCRIPTION:
% Create NEQsim Fluid object
%
% EXAMPLE:
% fluid = fluid(definedcomponents,oilcomponents);

pathNeqSim();

if nargin < 3
    unit = 'mole/sec';
end

fluidClass = neqsim.thermo.Fluid();
f = fluidClass.create2(definedcomponents.names,definedcomponents.composition,unit);

if nargin > 1
    f = fluidClass.addOilFractions(oilcomponents.names,oilcomponents.composition,oilcomponents.molarmass,oilcomponents.relativedensity,oilcomponents.plusfraction);
end