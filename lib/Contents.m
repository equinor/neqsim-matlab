% Toolbox neqsim
% Version 1.0 04-10-2001
%
% NeqSim toolbox for Matlab.
% Implemented methods:
%
% The variable system referes to a thermodyanmic system - eg. system = SystemSrkEos()
% t - temperature
% p- pressure
%
% All function return a vector with variables:
% 1. System property (mean/..)
% 2. Gas phase property
% 3. Liquid phase property
% 4. Number of phases
%
% If t or p are specified in the function call - a TPflash is done.
% If not - no flash is done.
%
% enthalpy(system,t,p)
% energy(system,t,p)
% molarmass(system,t,p)
% enthalpy(system,t,p)
% Z(system,t,p)
% dynvisc(system,t,p)
% gibbsenergy(system,t,p)
% helmholtzenergy(system,t,p)
% entropy(system,t,p)
% kinvisc(system,t,p)
% moles(system,t,p)
% molfrac(system,t,p)
% conductivity(system,t,p)