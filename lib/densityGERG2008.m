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
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar helmholtzenergy, gas molar helmholtzenergy, liquid molar helmholtzenergy
% and the number of phases.
%
% Even Solbraa, 2001.
%
% EXAMPLE:
% densGERG = densityGERG2008(phase);

pathNeqSim();

GERGfluid = neqsim.thermo.util.GERG.NeqSimGERG2008();
densGERG = GERGfluid.getDensity(phase);
