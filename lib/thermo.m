function thermoSystem = thermo(eosname,t,p)
% Create thermoSystem
% function thermoSystem = thermo(eosname,t,p)
%
% OPTIONAL INPUT:
%  - eosname      - Type of EOS method. Defaults to 'srk'
%  - t            - Temperature of thermoSystem
%  - p            - Pressure of thermoSystem
%
% OUTPUT:
%  - thermoSystem - Thermodynamic system object
%
% DESCRIPTION:
% Create thermoSystem
% EOS methods supported (case-insensitive):
% srk, pr, cpa, srk-mc, umr, GERG2004, ScSrk, electrolyte, electrolyteCPA, UMR-PRU-EoS
%
% EXAMPLE:
% system = thermo(eosname,temp,pres);

narginchk(0,3);

pathNeqSim();

if nargin < 1
    eosname = 'srk';
end

if nargin < 2
    t = 298.15;
end

if nargin < 3
    p = 1.0;
end

switch upper(eosname)
    case upper('srk')
        thermoSystem = neqsim.thermo.system.SystemSrkEos(t,p);
    case upper('pr')
        thermoSystem = neqsim.thermo.system.SystemPrEos(t,p);
    case upper('cpa')
        thermoSystem = neqsim.thermo.system.SystemSrkCPAstatoil(t,p);
    case upper('srk-mc')
        thermoSystem = neqsim.thermo.system.SystemSrkMathiasCopeman(t,p);
    case upper('umr')
        thermoSystem = neqsim.thermo.system.SystemUMRPRUMCEos(t,p);
    case upper('GERG2004')
        thermoSystem = neqsim.thermo.system.SystemGERG2004Eos(t,p);
    case upper('ScSrk')
        thermoSystem = neqsim.thermo.system.SystemSrkSchwartzentruberEos(t,p);
    case upper('electrolyte')
        thermoSystem = neqsim.thermo.system.SystemFurstElectrolyteEos(t,p);
    case upper('electrolyteCPA')
        thermoSystem = neqsim.thermo.system.SystemElectrolyteCPAstatoil(t,p);
    case upper('UMR-PRU-EoS')
        thermoSystem = neqsim.thermo.system.SystemUMRPRUMCEos(t,p);
    otherwise
        warning('neqsim:thermo:eosNotFound','Method %s not found. Using default method srk',eosname);
        thermoSystem = neqsim.thermo.system.SystemSrkEos(t,p);
end