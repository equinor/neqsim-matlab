function densGERG = densityGERG2008(phase)
% Calculates the helmholtzenergy for a given thermodyanmic system
% If temperature or pressure are specified - a TP flash is done.
% THe output is total molar helmholtzenergy, gas molar helmholtzenergy, liquid molar helmholtzenergy
% and the number of phases.
%
% Even Solbraa, 2001.
%

pathNeqSim();

GERGfluid = neqsim.thermo.util.GERG.NeqSimGERG2008();
densGERG = GERGfluid.getDensity(phase);