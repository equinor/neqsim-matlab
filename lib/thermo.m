function system = thermo(eosname, temp, pres)
if(nargin<1) 
    eosname = 'srk';
    disp('No method specified. Using default method : SRK-EOS')
end
if(strcmp('srk',eosname))
    system = neqsim.thermo.system.SystemSrkEos(298,1.0);
elseif(strcmp('pr',eosname))
        system = neqsim.thermo.system.SystemPrEos(298,1.0);
elseif(strcmp('cpa',eosname))
        system = neqsim.thermo.system.SystemSrkCPAstatoil(298,1.0);
elseif(strcmp('srk-mc',eosname))
        system = neqsim.thermo.system.SystemSrkMathiasCopeman(298,1.0);
elseif(strcmp('umr',eosname))
        system = neqsim.thermo.system.SystemUMRPRUMCEos(298,1.0);
elseif(strcmp('GERG2004',eosname))
        system = neqsim.thermo.system.SystemGERG2004Eos(298,1.0);
elseif(strcmp('ScSrk',eosname))
        system = neqsim.thermo.system.SystemSrkSchwartzentruberEos(298,1.0);
elseif(strcmp('electrolyte',eosname))
        system = neqsim.thermo.system.SystemFurstElectrolyteEos(298,1.0);
elseif(strcmp('electrolyteCPA',eosname))
        system = neqsim.thermo.system.SystemElectrolyteCPAstatoil(298,1.0);
elseif(strcmp('UMR-PRU-EoS',eosname))
        system = neqsim.thermo.system.SystemUMRPRUMCEos(298,1.0);
else
        system = neqsim.thermo.system.SystemSrkEos(298,1.0);
end

 if(nargin>=3)
     system.setPressure(pres);
 end
 if(nargin>=2)
     system.setTemperature(temp);
 end