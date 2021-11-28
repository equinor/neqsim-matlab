function system = thermoArray(eosname,numb,temp,pres)
% Create array of thermoSystem objects
% function system = thermoArray(eosname,numb,temp,pres)
%
% INPUT:
%  - eosname - Type of EOS. Supports 'pr' and 'srk'. Defaults to srk
%  - numb    - Number of elements to create. Defaults to 1.
%  - temp    - Temperatures per element or single temperature for all.
%  - pres    - Pressure per element or single pressure for all.
%
% OUTPUT:
%  - system  - Array of thermoSystem objects
%
% DESCRIPTION:
% Create array of thermoSystem objects
%
% EXAMPLE:
% system = thermoArray(eosname,numb,temp,pres);

narginchk(2,4);

if nargin < 1
    eosname = 'srk';
    disp('No method specified. Using default method : SRK-EOS')
end

if nargin < 2 || isempty(numb)
    numb = 1;
end

if strcmpi('pr',eosname)
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
    if strcmpi('pr',eosname)
        system(m) = neqsim.thermo.system.SystemPrEos(temp1(m),pres1(m));
    else
        system(m) = neqsim.thermo.system.SystemSrkEos(temp1(m),pres1(m));
    end
end