function densGERG = densityGERG2008(phase)
% Calculates the density using GERG2008 for a given thermodynamic system
% function densGERG = densityGERG2008(phase)
%
% INPUT:
%  - phase    - Desc
%
% OUTPUT:
%  - densGERG - Desc
%
% DESCRIPTION:
% Calculates the density using GERG2008 for a given thermodynamic system
%
% EXAMPLE:
% densGERG = densityGERG2008(phase);

narginchk(1,1);

pathNeqSim();

% todo: does this make sense?

GERGfluid = neqsim.thermo.util.GERG.NeqSimGERG2008();
densGERG = GERGfluid.getDensity(phase);