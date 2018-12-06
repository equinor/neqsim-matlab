function system = thermoArray(eosname, numb, temp, pres)

if(nargin<1) 
    eosname = 'srk';
    disp('No method specified. Using default method : SRK-EOS')
end
if(strcmp('srk',eosname))
    system = javaArray('thermo.system.SystemSrkEos',numb);
elseif(strcmp('pr',eosname))
    system = javaArray('thermo.system.SystemPrEos',numb);
else
    system = javaArray('thermo.system.SystemSrkEos',numb);
end

 if nargin>=4
     if size(pres)==1
        pres1 = linspace(pres, pres, numb);
     else
        pres1 = pres;
    end
 else
     pres1 = linspace(1.0, 1.0, numb);
 end
 
 if nargin>=3
     if size(temp)==1
        temp1 = linspace(temp, temp, numb);
    else
        temp1 = temp;
    end
 else
     temp1 = linspace(298.15, 298.15, numb);
 end
 
 for m=1:numb
     if(strcmp('srk',eosname))
        system(m) = SystemSrkEos(temp1(m),pres1(m));
    elseif(strcmp('pr',eosname))
        system(m) = SystemPrEos(temp1(m),pres1(m));
    else
        system(m) = SystemSrkEos(temp1(m),pres1(m));
    end
 end
 system;
 