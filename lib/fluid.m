function fluid = fluid(definedcomponents, oilcomponents)

unit = 'mole/sec';
fluidClass = neqsim.thermo.Fluid();
fluid = fluidClass.create2(definedcomponents.names, definedcomponents.composition, unit);
if nargin > 1 
    fluid = fluidClass.addOilFractions(oilcomponents.names, oilcomponents.composition ,oilcomponents.molarmass, oilcomponents.relativedensity, oilcomponents.plusfraction);
end
end
