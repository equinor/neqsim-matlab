function system = thermoArray(eosname,numb,temp,pres)
% Summary description
% function system = thermoArray(eosname,numb,temp,pres)
%
% INPUT:
%  - eosname - Desc
%  - numb    - Desc
%  - temp    - Desc
%  - pres    - Desc
%
% OUTPUT:
%  - system  - Desc
%
% DESCRIPTION:
%
%
% EXAMPLE:
% system = thermoArray(eosname,numb,temp,pres);

narginchk(2,4);

if nargin < 1
    eosname = 'srk';
    disp('No method specified. Using default method : SRK-EOS')
end
if (strcmp('pr',eosname))
    system = javaArray('neqsim.thermo.system.SystemPrEos',numb);
else
    system = javaArray('neqsim.thermo.system.SystemSrkEos',numb);
end

if nargin > 2
    if size(temp) == 1
        temp1 = repmat(temp,1,numb);
    else
        temp1 = temp;
    end
else
    temp1 = repmat(298.15,1,numb);
end

if nargin > 3
    if size(pres) == 1
        pres1 = repmat(pres,1,numb);
    else
        pres1 = pres;
    end
else
    pres1 = repmat(1.0,1,numb);
end

for m = 1:numb
    if (strcmp('pr',eosname))
        system(m) = neqsim.thermo.system.SystemPrEos(temp1(m),pres1(m));
    else
        system(m) = neqsim.thermo.system.SystemSrkEos(temp1(m),pres1(m));
    end
end
