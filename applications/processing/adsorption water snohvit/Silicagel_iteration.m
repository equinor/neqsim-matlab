
function[Tgasnew, Tadnew, mwadnew, mwgnew] = Silicagel_iteration(Tgasj,Tadj,mwaj,Mgasj,mwgj,dmaSG,q,mwsg,Tdewf,Twall,Mdewf) %[ut]=f(in)

Cpg=2.73;
Cpa=1.07;
CpH2O=4.3;
hvap=4187;

%values to use in the function mwsg
     
MWgas=18.54;
MWwater=18.02;
Rw=8.314/MWwater;
ppmj=(10^6*(mwgj*MWgas/(Mgasj*MWwater)));
    if isnan(ppmj)==1 || isinf(ppmj)==1 || ppmj==0
       ppmj=0.1;
    end
yi=10^-6*ppmj;

k10=0.65*5.2E-12;
Qst=2.38E3;
Ppa=61E5; %Pa
T=Tadj; Tgasnew=Tgasj;

if mwaj<dmaSG*mwsg(yi,Tadj) %Checking if water content is so that ADsorption might happen
    %first: only heat transfer:
    Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
    Tadnew=Tadj+q/(mwaj*CpH2O+dmaSG*Cpa); %new adsorbent temperature calculated from q
    mwgnew=mwgj;
    if mwaj<dmaSG*mwsg(yi,Tadnew) %if mwa still is below equilibrium (T or mwad too low for equilibrium)
        %water can be adsorbed from the gas!
        mwadnew=mwaj; Tadj=Tadnew; Qads=0; dQads=0;
        while mwadnew<dmaSG*mwsg(yi,Tadnew) && mwgnew>0
            mwadnew=mwadnew+0.05*mwgj;
            mwgnew=mwgnew-0.05*mwgj;
            dQads=0.05*mwgj*(hvap+CpH2O*(Tgasnew-Tadnew));
            Qads=Qads+dQads;
            Tadnew=Tadj+(Qads)/(mwaj*CpH2O+dmaSG*Cpa);
        end
        mwadnew=mwadnew-0.05*mwgj;  %taking back the last 5% so that we're still below eqiuilibrium
        mwgnew=mwgnew+0.05*mwgj;
        Tadnew=Tadnew-(dQads)/(mwaj*CpH2O+dmaSG*Cpa);
    
    else %adsorbent temperature has increased too much and is now above equilibrium
        %return to equilibrium
        equilibT=Qst/(Rw*log(mwaj/(Ppa*k10*yi*(dmaSG-mwaj)))) -273.15; %solving for temperature at the current water (in adsorbent) content
        q=(Tadnew-equilibT)*(Cpa*dmaSG+mwaj*CpH2O); %going "back to equilibrium" to iterate on adsorption from there
        Tadj=equilibT; Tgasj=Tgasnew+(q/(Cpg*Mgasj+CpH2O*mwgj));
        qmax=q; qbig=0; Tgasmax=Tgasj;
       
                              
                              
                                                     %%%%ITERATIONS%%%
                              
        format long
        Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
        Tadnew=Tadj;
        Tadmin=Tadj; Tadmax=Tgasnew; %Values to limit the iterations
        deltaT=Tgasj-Tgasnew; %delta T for the gas
        GASenergy=deltaT*(Cpg*Mgasj+CpH2O*mwgj); % energy that the gas gives away (should in most cases be == q )
        Tadnew=0.1*(9*Tadj+Tgasnew); %Guessing for a new adsorbent temperature and iterating for the correct adsorbent temperautre corresponding to the as temperature
        mwadnew=mwaj;
        %Iterating for correct adsorbent temperature corresponding to gas
        %temperature
        deltatad=10;
        while deltatad>0.0001 || mwadnew>mwaj 
            mwadnew=dmaSG*mwsg(yi,Tadnew);    %The new % equilibrium water content in adsorbent
            heatad=Cpa*dmaSG*(Tadnew-Tadj); %energy to heat the adsorbent
            heatH2Oads=CpH2O*(mwadnew)*(Tadnew-Tadj); %Energy to heat water in adsorbent
            heatdes=hvap*(mwaj-mwadnew); %energy to desorb water
            heatH2Odes=CpH2O*(Tgasnew-Tadj)*(mwaj-mwadnew); %energy to heat desorbed water to gas temperature
            ADenergy=heatad+heatH2Oads+heatH2Odes+heatdes+heatH2Odes; %total energy required to get the new adsorbent temperature
            Tadold=Tadnew;
            if ADenergy>GASenergy %Tadnew must be reduced
                Tadmax=Tadnew;
                Tadnew=Tadmin+(Tadnew-Tadmin)/3;
            else %ADenergy<Gasenergy -> Tadnemw must be increased
                Tadmin=Tadnew;
                Tadnew=(Tadmax+Tadnew)/2;
            end
            deltatad=abs(Tadold-Tadnew); %change in temperature
        end
    end
                                                %%%ITERATIONS END%%%
else %only desorption, no deltaT
    if q>0.001 && Tgasj-Tadj>0.05 && Tgasj>Tdewf(mwgj/Mgasj) && mwgj< min(Mdewf(Twall)*Mgasj,Mdewf(Tadj)*Mgasj)
    desorbed=q/hvap;
    if mwaj-desorbed<dmaSG*mwsg(yi,Tadj)
        desorbed=mwaj-dmaSG*mwsg(yi,Tadj);
        mwaj=mwaj-desorbed;
        mwgj=mwgj+desorbed;
        Tgasj=Tgasj-((desorbed*hvap)/(Cpg*Mgasj+CpH2O*mwgj));
        q=q-hvap*desorbed;
        
                                    %%%ITERATIONS%%%
                    
        format long
        Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
        Tadnew=Tadj;
        Tadmin=Tadj; Tadmax=Tgasnew; %Values to limit the iterations
        deltaT=Tgasj-Tgasnew; %delta T for the gas
        GASenergy=deltaT*(Cpg*Mgasj+CpH2O*mwgj); % energy that the gas gives away (should in most cases be == q )
        Tadnew=0.1*(9*Tadj+Tgasnew); %Guessing for a new adsorbent temperature and iterating for the correct adsorbent temperautre corresponding to the as temperature
        mwadnew=mwaj;
        %Iterating for correct adsorbent temperature corresponding to gas
        %temperature
        deltatad=10;
        while deltatad>0.0001 || mwadnew>mwaj %|| abs(ADenergy-GASenergy)<0.05
            mwadnew=dmaSG*mwsg(yi,Tadnew);    %The new % equilibrium water content in adsorbent
            heatad=Cpa*dmaSG*(Tadnew-Tadj); %energy to heat the adsorbent
            heatH2Oads=CpH2O*(mwadnew)*(Tadnew-Tadj); %Energy to heat water in adsorbent
            heatdes=hvap*(mwaj-mwadnew); %energy to desorb water
            heatH2Odes=CpH2O*(Tgasnew-Tadj)*(mwaj-mwadnew); %energy to heat desorbed water to gas temperature
            ADenergy=heatad+heatH2Oads+heatH2Odes+heatdes+heatH2Odes; %total energy required to get the new adsorbent temperature
            Tadold=Tadnew;
            if ADenergy>GASenergy %Tadnew must be reduced
                Tadmax=Tadnew;
                Tadnew=Tadmin+(Tadnew-Tadmin)/3;
            else %ADenergy<Gasenergy -> Tadnemw must be increased
                Tadmin=Tadnew;
                Tadnew=(Tadmax+Tadnew)/2;
            end
            deltatad=abs(Tadold-Tadnew); %change in temperature
        end
        mwgnew=mwgj+(mwaj-mwadnew);
    else
        desorbed=(q)/hvap;
        maxdesorb=0.25*Mdewf(Tgasj)*Mgasj;
        desorbed=min(maxdesorb,desorbed);
        mwadnew=mwaj-desorbed;
        mwgnew=mwgj+desorbed;
        qleft=q-(desorbed*hvap);
        %Tadnew=Tadj;
        Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj));
        Tadnew=Tadj+(qleft)/(mwadnew*CpH2O+dmaSG*Cpa);
    end
                    %%%ITERATIONS END%%%
    elseif q<0 %Cooling
        Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
        Tadnew=Tadj+q/(mwaj*CpH2O+dmaSG*Cpa); %new adsorbent temperature calculated from q
        mwgnew=mwgj;
        mwadnew= mwaj;
        
    else % Gas is saturated- water can't be desorbed. Only heat transfer
        Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
        Tadnew=Tadj+q/(mwaj*CpH2O+dmaSG*Cpa); %new adsorbent temperature calculated from q
        mwgnew=mwgj;
        mwadnew= mwaj;
    end
end
end


    
    