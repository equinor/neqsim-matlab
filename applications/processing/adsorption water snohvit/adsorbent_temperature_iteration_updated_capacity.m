
%denne funksjonen itererer bare slik at adsorbent temperatur blir korrekt
%ved en gitt gasstemeratur!

function[Tgasnew, Tadnew, mwadnew, gasincrease] = adsorbent_temperature_iteration_updated_capacity(Tgasj,Tadj,mwaj,Mgasj,mwgj,dma,q, qbig, mwadp) %[ut]=f(in)
Cpg=2.73;
Cpa=1.07;
CpH2O=4.3;
hvap=4187;

%values to use in the function mwadp
P=51*10^2; %System pressure
R=8.314;        
CH4C=[348.971 0.542 6.770E-06 13672.210; 348.971 0.542 6.130E-07 20307.220];
H2OC=[-3799.940 18.711 3.580E-07 44140.040;3684.491 -4.450 1.620E-05 45199.990];
MWgas=18.54;
MWwater=18.02;
ppmj=(10^6*(mwgj*MWgas/(Mgasj*MWwater)));
    if isnan(ppmj)==1 || isinf(ppmj)==1 || ppmj==0
       ppmj=0.1;
    end
YH2O=10^-6*ppmj;

format long
Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
Tadnew=Tadj;
% Tgasnew=max(Tadj+0.001,Tgasnew);      %Making sure the new gas temperature is higher than the adsorbent temperature
%q=(Tgasj-Tgasnew)*(Cpg*Mgasj+CpH2O*mwgj);
Tadmin=Tadj; Tadmax=Tgasnew; %Values to limit the iterations
deltaT=Tgasj-Tgasnew; %delta T for the gas
GASenergy=deltaT*(Cpg*Mgasj+CpH2O*mwgj); % energy that the gas gives away (should in most cases be == q )


if q>0
gasincrease=0; %Constant used to determine if Tgasnew is too low
Tadnew=0.1*(9*Tadj+Tgasnew); %Guessing for a new adsorbent temperature and iterating for the correct adsorbent temperautre corresponding to the as temperature
mwadnew=mwaj;
%Iterating for correct adsorbent temperature corresponding to gas
%temperature
deltatad=10;
while deltatad>0.0001 || mwadnew>mwaj %|| abs(ADenergy-GASenergy)<0.05
     mwadnew=dma*mwadp(YH2O,Tadnew);    %The new % equilibrium water content in adsorbent
     heatad=Cpa*dma*(Tadnew-Tadj); %energy to heat the adsorbent
     heatH2Oads=CpH2O*(mwadnew)*(Tadnew-Tadj); %Energy to heat water in adsorbent
     heatdes=hvap*(mwaj-mwadnew); %energy to desorb water
     heatH2Odes=CpH2O*(Tgasnew-Tadj)*(mwaj-mwadnew); %energy to heat desorbed water to gas temperature
     ADenergy=heatad+heatH2Oads+heatH2Odes+heatdes+heatH2Odes; %total energy required to get the new adsorbent temperature
     Tadold=Tadnew;
     if ADenergy>GASenergy %Tadnew must be reduced
         Tadmax=Tadnew;
         Tadnew=Tadmin+(Tadnew-Tadmin)/3;
%        elseif Tgasnew-Tadnew<0.0005 && (GASenergy-ADenergy)>0.01 %If this occurs, the gas temperature is too small!
%          gasincrease=1;
       elseif abs(Tgasnew-Tadnew)<0.01 && (GASenergy-ADenergy)<0.1 && qbig>0 %if this occurs, the gas temerature is too large!
         gasincrease=2;
     else %ADenergy<Gasenergy -> Tadnemw must be increased
         Tadmin=Tadnew;
         Tadnew=(Tadmax+Tadnew)/2;

     end
     deltatad=abs(Tadold-Tadnew); %change in temperature
end

% mwadnew=dma*polyval(mwapercentp,Tadnew);    %The new % equilibrium water content in adsorbent
end



% Tadnew;
% Tgasnew;
% mwadnew;
% gasincrease;

    

