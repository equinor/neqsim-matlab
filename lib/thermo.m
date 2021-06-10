function system = thermo(eosname,t,p)
% Summary description
% function system = thermo(eosname,t,p)
%
% OPTIONAL INPUT:
%  - eosname - Desc
%  - t       - Desc
%  - p       - Desc
%
% OUTPUT:
%  - system  - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% system = thermo(eosname,temp,pres);

narginchk(0,3);

pathNeqSim();

if nargin < 1
    eosname = 'srk';
    %     disp('No method specified. Using default method : SRK-EOS')
end

if nargin < 2
    t = 298.15;
end

if nargin < 3
    p = 1.0;
end

switch upper(eosname)
    case upper('srk')
        system = neqsim.thermo.system.SystemSrkEos(t,p);
    case upper('pr')
        system = neqsim.thermo.system.SystemPrEos(t,p);
    case upper('cpa')
        system = neqsim.thermo.system.SystemSrkCPAstatoil(t,p);
    case upper('srk-mc')
        system = neqsim.thermo.system.SystemSrkMathiasCopeman(t,p);
    case upper('umr')
        system = neqsim.thermo.system.SystemUMRPRUMCEos(t,p);
    case upper('GERG2004')
        system = neqsim.thermo.system.SystemGERG2004Eos(t,p);
    case upper('ScSrk')
        system = neqsim.thermo.system.SystemSrkSchwartzentruberEos(t,p);
    case upper('electrolyte')
        system = neqsim.thermo.system.SystemFurstElectrolyteEos(t,p);
    case upper('electrolyteCPA')
        system = neqsim.thermo.system.SystemElectrolyteCPAstatoil(t,p);
    case upper('UMR-PRU-EoS')
        system = neqsim.thermo.system.SystemUMRPRUMCEos(t,p);
    otherwise
        system = neqsim.thermo.system.SystemSrkEos(t,p);
end