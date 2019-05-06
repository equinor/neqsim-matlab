%This code simulates the temperature of the gas, adsorbent and wall of 23-VK-101A/B/C at Hammerfest LNG
%The time at which the temperature should be calculated is tmax [s]. The
%code can can also produce temperature profiles of the column at given
%times. Lines with two stars (**) can be edited

clear all
clc
format long

%Defining physical properties of the system

%Column
d= 4.000;  %diameter of column [m]
ww= 0.0078;  %wall thickness [m]
height= 6.30+0.355+0.355;  %height of column - MS layer+ 2x ceramic ball layer [m]
Qmh=60500;  %Gas mass flow rate [kg/h] (**)
Qm=Qmh/3600 ;  %Gas mass flow [kg/s]
channeling=0; Channeling=100*channeling; % % part of gas that's channeling- if the effect of channeling (all the way through the column) is to be investigated


%Defining grids

ny=266;  %Number of nodes in the y-direction (**)
nyMS=240; %Number of nodes in the MS layer. NOTE: the CB layer is sat to be 13 nodes each with this configuration
nxw=5; %Number of nodes in the wall in the x- direction (**)

dy=height/ny; %step size in the y-direction
dxw=ww/nxw;  %step size in the wall (x-direction)

tmax=470*60; %[s] Total duration of desorption (**)
dt=0.1;  % [s] size of timestep (**)
nt=tmax/dt; %total number of time steps

xA=(pi()*d^2)/4; %cross sectional area of column
aA=0.62*xA;  %Area the adsobent is filling (poured packing- filling factor =0.62)
Af=xA-aA; %free cross sectional area for the gas to flow


%adsorbent properties

hvap=4187; %[kJ/kg] -energy to break adsorbtion bond
Cpa=1.07; %[kJ/kgK] heat capacity of adsorbent 
densa=720; %[kg/m3]density of adsorbent 
Tadsinitial=25;  %initial temperature of adsorbent (at start of regeneration)
massadsorbent= 54400;  %[kg]total mass of the adsorbent in the column 
dma=massadsorbent/nyMS; %kg adsorbent per height segment
% dmaSG=0.7*dma; %Applicable for silica gel simulations


% Making the capacity equation
P=61*10^2; %System pressure [kPa] (**)
Ppa=P*1000; %System pressure in [Pa] - to use in mwsg (Silica Gel)
R=8.314;  %gas constant

%Constants for Langmuir equation follows
CH4C=[348.971 0.542 6.770E-06 13672.210; 348.971 0.542 6.130E-07 20307.220];
H2OC=[-3799.940 18.711 3.580E-07 44140.040;3684.491 -4.450 1.620E-05 45199.990];
C11=CH4C(1,1); C12=CH4C(1,2); C13=CH4C(1,3); C14=CH4C(1,4);
C21=CH4C(2,1); C22=CH4C(2,2); C23=CH4C(2,3); C24=CH4C(2,4);
H11=H2OC(1,1); H12=H2OC(1,2); H13=H2OC(1,3); H14=H2OC(1,4);
H21=H2OC(2,1); H22=H2OC(2,2); H23=H2OC(2,3); H24=H2OC(2,4);
%T is in kelvin, but as it is added 273 in the equation, C is used
        
%Defining MS capacity from Langmuir multicomponent adsorption (Water/C1 - MS 5A):
mwadp=@(YH2O,T) 0.725*((H2OC(1,1)/(T+273) + H2OC(1,2))*(H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*YH2O/(1+((H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*YH2O+(CH4C(1,3)*exp(CH4C(1,4)/(R*(T+273))))*P*(1-YH2O)))+(H2OC(2,1)/(T+273) + H2OC(2,2))*(H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*YH2O/(1+((H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*YH2O+ (CH4C(2,3)*exp(CH4C(2,4)/(R*(T+273))))*P*(1-YH2O))))*18.015/1000;
funT=@(T) 0.725*((H2OC(1,1)/(T+273) + H2OC(1,2))*(H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*YH2O/(1+((H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*YH2O+(CH4C(1,3)*exp(CH4C(1,4)/(R*(T+273))))*P*(1-YH2O)))+(H2OC(2,1)/(T+273) + H2OC(2,2))*(H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*YH2O/(1+((H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*YH2O+ (CH4C(2,3)*exp(CH4C(2,4)/(R*(T+273))))*P*(1-YH2O))))*18.015/1000;
funT1ppm=@(T) dma*0.725*((H2OC(1,1)/(T+273) + H2OC(1,2))*(H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*10^-6/(1+((H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*10^-6+(CH4C(1,3)*exp(CH4C(1,4)/(R*(T+273))))*P*(1-10^-6)))+(H2OC(2,1)/(T+273) + H2OC(2,2))*(H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*10^-6/(1+((H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*10^-6+ (CH4C(2,3)*exp(CH4C(2,4)/(R*(T+273))))*P*(1-10^-6))))*18.015/1000;

%The following is applicable in silica gel simulations
% % %Defining Silica gel capacity from vant Hoff equation (Silica gel 3A/water)
% % k10=0.65*5.2E-12;
% % Qst=2.38E3;
% % Rw=8.314/18.02; %kj/kgK / j/gK
% % T=25;
% % mwsg= @(yi,T) k10*exp(Qst/(Rw*(T+273.15)))*Ppa*yi/(1+k10*exp(Qst/(Rw*(T+273.15)))*Ppa*yi);

yi=730*10^-6; %feed gas water content

%The Following creates bed saturation (1/3 bed) and mass transfer zone
%(0.7m)
% MTZ_length=0.7; % Length of MTZ in [m]
% dmwater=mwadp(730*10^-6,25); %[kg] mass of water in adsorbent at initial conditions
% mwa=zeros(ny,1);
% mwa(round(7*ny/9 -2):ny)=dma*dmwater; % [kg] mass of water in each height segiment at start of regeneration
% for i=round(7*ny/9 -(MTZ_length*ny/6.3)):round(7*ny/9)
% sigmoid=(10/(round(7*ny/9)-round(7*ny/9 -(MTZ_length*ny/6.3)) ))*(i-round(7*ny/9 -(MTZ_length*ny/6.3)) ) -5;
% mwa(i)=dma*dmwater*(1/(1+exp(-sigmoid)));
% end
% mwa(ny-13:ny)=0;
% for i=ny-19:ny-13
%     mwa(i)=dmaSG*mwsg(yi,25);
% end  
 qneg=0; %parameter used in next line 
mwa=mwa_Base_Case(qneg);
%gas properties
hfgas=@(xx) (4*10^-6)*(xx)^3 - 0.0007*(xx)^2 +2.6643*(xx) - 66.2325; %[kJ/kg] enthalpy of gas as a function of temperature
Mdewf=@(xx) 0.000291*exp(0.039683*xx); %Water content at gas saturation as function of T
Tdewf=@(xx)  25.1997*log(3436.426*xx);%Gas temperature at water saturation as function og mwg
Cpg=2.73; %[kJ/kgK] heat capacity og the gas-  the value varies very little with temperature and is therefore sat constant
CpgSI=2730; %Cpg in SI units [J/kgK]
mwg=zeros(ny,1); %matrix for amount of water in the gas- zero at start of regeneration
mwg1=mwg; %dummy matrix to be used later
densgasf=@(tt) (9*10^-9)*(tt)^4 - (6*10^-6)*(tt)^3 + 0.0018*(tt)^2 -0.3401*(tt) + 57.071; % [kg/m3] density of the gas as f(Tgas)
viscgasf=@(uu) (3*10^-13)*(uu)^4 - (1*10^-10)*(uu)^3 + (3*10^-6)*(uu)^2 + 0.0001; %[Pa*s] -viscosity of the gas as f(Tgas)
condgasf=@(vv) (-3*10^-10)*(vv)^3 + (3*10^-7)*(vv)^2 + (1*10^-4)*(vv) + 0.0359; % [W/m2] -thermal conductivity of gas as f(Tgas)
Mgasentering=(1-channeling)*Qm*dt; %{kg] amount of gas that enters the column every timestep
Tg=@(xx) (-2.53123*10^-13)*(xx)^5 +(4*10^-10)*(xx)^4 - (3.33*10^-7)*(xx)^3 +(9*10^-5)*(xx)^2 + 0.3745*(xx) + 25; %[C]temperature of gas as a f(enthalpy)
MWgas=18.54; %MW of the gas
MWwater=18.02; %MW of water

%ceramic ball properties
mCpCB=5500*0.84/13; %mCp ceramic balls in one height segment- density is 0.84 kg/m3 and there are 13 height segments

%water properties
CpH2O=4.3; %[kJ/kgK] heat capacity of water. this is sat constant both for liquid and vapor water

%matrices used for calculate the gas movement upwards the column
movecells=zeros(ny,1);     
moveHcells=zeros(ny,1);
densgas=zeros(ny,1);
movegascells=zeros(ny,1);
dtdivdy=dt/dy;  %constant to ease code

%wall properties
Cpw=513; %[J/kgK] heat capacity of wall  
CpwSI=0.001*Cpw; %heat capacity in [kJ/kgK]
kw=15.8;  %[W/mK] heat transfer coefficient of wall 
densw=7990; %[kg/m3] density of wall material (steel) (sat constant with value for 400K) 
hwa= 120; %[W/m2K] convection heat transfer coefficient wall/adsorbent.
hws=12; %[W/m2K] convection heat transfer coefficient wall/surroundings. 

%definition of constants to ease the code:

%wall constants
alpha=kw/(densw*Cpw);
alphax=(alpha*dt)/dxw^2; %must be bigger than 0.25 IMPORTANT (stability criteria)
alphay=(alpha*dt)/dy^2; %must be bigger than 0.25 IMPORTANT (stability criteria)
if alphax>0.25 %reports if values are so that the model is unstable          
    display('ALPHAX TOO LARGE')
    display(alphax);
end
htx=(hwa*dt)/(dxw*Cpw*densw); %constant used in wall iteration
hxk=hwa*dxw/kw; %constant used in wall iteration
hxs=hws*dxw/kw; %constant used in wall iteration



% Defining initial conditions:

Tw=25*ones(nxw,ny); %wall  temperature matrix
Tw1=Tw; %dummy matrix for wall temp

Tgas=25*ones(ny,1); %Temperature of gas in column at start of regeneration
Hgas=zeros(ny,1); %enthalpy of gas in each segment at start of regeneration
Hgas1=Hgas;  %dummy matrix
Hintot=0; %to track total amount of energy entering the column
Tad=25*ones(ny,1);%initial temperature of adsorbent
Mgas=zeros(ny,1); %initial amount of gas in column
Mgas1=Mgas;  %dummy matrix
Vg=zeros(ny,1); %initial velocities gas upwards the column
Energyout=zeros(ny,1); %to calculate the energy loss to surrondings
Energyouttot=zeros(ny,1); %to calculate the total amount of energy lost to surrondings
Energyin=zeros(ny,1); %to track heat transfer from bed to wall
Energyintot=zeros(ny,1); %to track total heat transfer from bed to wall
free_water=zeros(ny,1); %amount of condensed water in given height segment
ppm=0.1*ones(ny,1); %ppm in height segment. minimum ppm =0.1 for capacity function to be /=0
tout=zeros((tmax/60),2); tout(1,1)=1; tout(1,2)=25; %To track temperature out as a function of time
heatdistmatrix=zeros(ny,3); %matrix to ease plotting after code execution
tempwall=zeros((tmax/60),10); %wall temperature- used for plotting
tempad=zeros((tmax/60),10); %adsorbent temperature - used for plotting
minu=1; %minutes into simulation. rounded upwards for 1st minute to fit in matrices
condensedtime=zeros((tmax/60),1);  condensedtimead=zeros((tmax/60),1); %tracking time of re- condensation
condensedposad=zeros(ny,1); condensedpos=zeros(ny,1); %tracking position of re- condensation
evaporatedtime=zeros((tmax/60),1); %tracking time of re- evaporation
waterouttime=zeros((tmax/60),1); ppmouttime=zeros((tmax/60),1); saturationouttime=zeros((tmax/60),1);  %tracking amount of gas exiting column relative to time
gasout=0; waterout=0; %tracking amount of gas an water exiting the column
%Tempin=inlet_gas_temperature_normal_long(qneg); %function to define inlet gas temperatures
Tempin=inlet_gas_temperature_November(qneg); %function to define inlet gas temperatures
    %%%%%%%%CALCULATIONS%%%%%%%
      
wbar = waitbar(0,'Please wait...');  %defining the waitbar

for timestep=1:nt;   %timesteps
    t=dt*timestep; tm=t/60;  %t represents time [s] from start, tm [min]
    Tw=Tw1;  %dummy matrix (Wall temperature at t=n+1, Tw is at t=n)
    
    %Defining gas inlet properties
    if tm<=700 %+3600 %for ramping up the temperature from 25C to 231 C in 100 minutes + ramping up Q in 7 min
        
        if t<=7*60 %Ramping up gas flowrate
            Qmh=60500*t/420; Qm=Qmh/3600;
            Mgasentering=(1-channeling)*Qm*dt; %{kg] amount of gas that enters the column every timestep
        end
        tminutes=ceil(t/60);  
        Tgasin=Tempin(ceil(tminutes));  %25+tminutes*(231-25)/100- temperature ramped up to 231 in 100 minutes
        densgasinitial=densgasf(Tgasin);
        hgasinitial=(Tgasin-25)*Cpg;
        Vginitial=Qm/(Af*densgasinitial);
        Hgasentering=hgasinitial*Mgasentering;
        Hgaschanneling=channeling*Qm*dt*hgasinitial; %calculating the energy of the channeling gas
    else %after 100 minutes the gas inlet temperature is constant at 231 C
        Tgasentering=231;
        densgasinitial=26.2259; 
        hgasinitial=(Tgasentering-25)*Cpg; 
        Vginitial=Qm/(Af*densgasinitial);  %initail velocity of the gas in the y- direction of the column
        Hgasentering=hgasinitial*Mgasentering; %total enthalpy of gas entering
        Hgaschanneling=channeling*Qm*dt*hgasinitial; %calculating the energy of the channeling gas
    end
    Hintot=Hintot+Hgasentering; %total amount of energy entering the system
    
      
    
  for j=1:ny; %iteration in the y-direction
      
          % Gas re-condensation
                   if Tw(nxw,j)<Tdewf(mwg(j)/Mgas(j))
                       if Mdewf(Tw(nxw,j))*Mgas(j)>mwg(j)
                           display('line 188!!')
                           pause on
                       end
                       
                       if j<ny-13-7 %only a fraction of the gas is in contact with the wall. However, more of the gas is in contact with the top of the column
                           condensed=0.100*(mwg(j)-Mgas(j)*Mdewf(Tw(nxw,j)));
                       elseif j>=ny-13-7 && j<ny-13
                           condensed=0.125*(mwg(j)-Mgas(j)*Mdewf(Tw(nxw,j)));
                       elseif j>=ny-13 && j<ny
                           condensed=0.20*(mwg(j)-Mgas(j)*Mdewf(Tw(nxw,j)));
                       elseif j==ny
                           condensed=0.25*(mwg(j)-Mgas(j)*Mdewf(Tw(nxw,j)));
                       end
                     condensedpos(j)=condensedpos(j)+condensed;
                     condensedtime(ceil(minu))=condensedtime(ceil(minu))+condensed; %ceil() to avoid problems at the first timestep
                     mwg(j)=mwg(j)-condensed;
                    if mwg(j)<0
                        error('feil-mwg(j)<0')
                    end
                    free_water(j)=free_water(j)+condensed;
                    Hgas(j)=Hgas(j)+0.70*condensed*hvap;
                    Tgas(j)=25+(Hgas(j)-(mwg(j)*(Tgas(j)-25)*CpH2O))/(Mgas(j)*Cpg);
                    %making the re- condensation appear on the wall=
                    %transferring all energy to the wall
                    deltaTwall=0.30*condensed*hvap/(pi()*d*dxw*dy*densw*CpwSI);
                    Tw(nxw,j)=Tw(nxw,j)+deltaTwall; Tw(nxw-1,j)=Tw(nxw-1,j)+deltaTwall;
                    
                   end
                   
                    if Tad(j)<Tdewf(mwg(j)/Mgas(j))
                       if Mdewf(Tad(j))*Mgas(j)>mwg(j)
                           display('line 188!!')
                           pause on
                       end
                     condensed=0.9*(mwg(j)-Mgas(j)*Mdewf(Tad(j)));
                     condensedpos(j)=condensedpos(j)+condensed;
                     condensedposad(j)=condensedposad(j)+condensed;
                     condensedtime(ceil(minu))=condensedtime(ceil(minu))+condensed; %ceil() to avoid problems at the first timestep
                     condensedtimead(ceil(minu))=condensedtimead(ceil(minu))+condensed;
                     mwg(j)=mwg(j)-condensed;
                    if mwg(j)<0
                        error('feil-mwg(j)<0')
                    end
                    free_water(j)=free_water(j)+condensed;
                    Hgas(j)=Hgas(j)+0.5*condensed*hvap;
                    Tgas(j)=25+(Hgas(j)-(mwg(j)*(Tgas(j)-25)*CpH2O))/(Mgas(j)*Cpg);
                    if j>13 && j<ny-13
                    Tad(j)=Tad(j)+(0.5*condensed*hvap)/(dma*Cpa+mwa(j)*CpH2O);   %adsorbent temperature increases from latent heat
                    else
                    Tad(j)=Tad(j)+(0.5*condensed*hvap)/mCpCB;
                    end
                    end  
    
   
        %calculation of wall temperatures 
        if j>1 && j<ny % calculations in the y- direction ( constraints is because of the boundry conditions in the wall temperature calculations)
            Tadgas=0.5*(Tad(j)+Tgas(j));
         Tw1(1,j)=(Tw(2,j)+hxs*10)/(hxs+1); %wall-surroundings - ATMOSPHERIC TEMPERATURE IS SAT TO 10 CENTIGRADES
         Tw1(nxw,j)=(Tw(nxw-1,j)+hxk*Tadgas)/(hxk+1); %wall-adsorbent
         Tw1(nxw-1,j)=alphax*(Tw(nxw,j)-2*Tw(nxw-1,j)+Tw(nxw-2,j))+alphay*(Tw(nxw-1,j+1)-2*Tw(nxw-1,j)+Tw(nxw-1,j-1));
         
            for i=2:(nxw-1); %calculations in wall radial direction
                Tw1(i,j)=alphax*(Tw(i+1,j)+Tw(i-1,j))+alphay*(Tw(i,j+1)+Tw(i,j-1))+Tw(i,j)*(1-2*alphax-2*alphay);
            end %end calculations in wall radial direction
        end %end wall calculations
        Tw1(:,1)=Tw(:,2)+(Tw(:,2)-Tw(:,3));

         Energyout(j)=0.001*hws*dt*(Tw1(1,j)-10)*4*pi()*dy; %calculating the amount of energy that's lost to surroundings. 0.001 to convert to kJ
         Energyouttot(j)=Energyouttot(j)+Energyout(j); %tracking the total amount of energy lost to surroundings
         Energyin(j)=0.001*hwa*dt*(Tad(j)-Tw1(1,j))*4*pi()*dy; %tracking the amount of energy transferred from adsorbent to wall
         Energyintot(j)=Energyintot(j)+Energyin(j); %tracking the total amount of energy transferred from adsorbent to wall
         
         if j>13 && j<ny-13
             Tad(j)=Tad(j)-(Energyout(j))/(dma*Cpa+mwa(j)*CpH2O); %heat loss of adsorbent to surroundings subtracted from adsorbent
         else
             Tad(j)=Tad(j)-(Energyout(j))/mCpCB;
         end
              
        
        %%% GAS/ADSORBTION ITERATIONS %%%
         ppm(j)=(10^6*(mwg(j)*MWgas/(Mgas(j)*MWwater)));
         if isnan(ppm(j))==1 || isinf(ppm(j))==1 || ppm(j)==0 ||ppm(j)<0
             ppm(j)=0.1;
         end
         
         Tf=0.5*(Tgas(j)+Tad(j)); %arithmetic mean temperature of gas and adsorbent
         q1=0.001*dt*dy*1402.28*Qm*CpgSI*((CpgSI*viscgasf(Tf)/condgasf(Tf))^(-2/3))*((2.53*10^-4*Qm/viscgasf(Tf))^(-0.4069))*(Tgas(j)-Tad(j));    %heat transfer between gas and adsorbent from Geankoplis' relations (0.001 is to convert from J to kJ)
         qmax=0.92*(Tgas(j)-Tad(j))*(Cpg*Mgas(j)+CpH2O*mwg(j)); %max theoretical heat transfer possilble (by energy balance)
         q=min(q1,qmax); %if q1>qmax q must be sat min
         if q<0
             q=max(q1,qmax);
         end

 
         

         
                   %Water re-evaporation
                 if free_water(j)>0 && q>0.0001
                     if Tgas(j)>Tdewf(mwg(j)/Mgas(j)) && mwg(j)< min(Mdewf(Tw(nxw,j))*Mgas(j),Mdewf(Tad(j))*Mgas(j)) %the gas is not saturated with water, water can evaporate
                         maxevaporate=Mdewf(Tw(nxw,j))*Mgas(j)-mwg(j);
                         qmaxevaporate=maxevaporate*hvap;
                         
                         qevaporate=min(0.9*q, hvap*free_water(j));
                         evaporate=qevaporate/hvap;
                             Hgas(j)=Hgas(j)-qevaporate+(evaporate*CpH2O*(Tgas(j)-25));
                             mwg(j)=mwg(j)+evaporate;
                             Tgas(j)=25+(Hgas(j)-(mwg(j)*(Tgas(j)-25)*CpH2O))/(Mgas(j)*Cpg);
                             q=q-qevaporate;
                             free_water(j)=free_water(j)-evaporate;
                             evaporatedtime(ceil(minu))=evaporate+evaporatedtime(ceil(minu));
                     end
                 end
                 
       ppm(j)=(10^6*(mwg(j)*MWgas/(Mgas(j)*MWwater))); %if ppm=0, the MScapacity is 0- not possible
      if isnan(ppm(j))==1 || isinf(ppm(j))==1 || ppm(j)==0
          ppm(j)=0.1;
      end          
        Tgasj=Tgas(j); Tadj=Tad(j); mwaj=mwa(j); Mgasj=Mgas(j); mwgj=mwg(j); mwadnew=mwa(j); ppmj=ppm(j);
         if abs(mwgj)<10^-12
             mwg(j)=0; mwgj=0;
         end                
        if j>13 && j<=ny-13                     
% %         if j<=ny-13 -7 %iteration in the MS layer  
             if q>0.001 && Tgas(j)-Tad(j)>0.5 && Tgas(j)>Tdewf(mwg(j)/Mgas(j)) %0.001 instead of 0 to avoid iterations with too small values
                 
                 %if ADsorption might happen
                 if mwaj<dma*mwadp(10^-6*ppmj,Tad(j)) %Checking if water content is so that ADsorption might happen
                     
                     %first: only heat transfer:
                     Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
                     Tadnew=Tadj+q/(mwaj*CpH2O+dma*Cpa); %new adsorbent temperature calculated from q
                     mwgnew=mwgj;
                     
                     if mwaj<dma*mwadp(10^-6*ppm(j),Tadnew) %if mwa still is below equilibrium (T or mwad too low for equilibrium)
                            %water can be adsorbed from the gas!

                    else %adsorbent temperature has increased and is now above equilibrium (dma*mwadp(10^-6*ppm(j),Tadnew)<mwa)
                                T=Tgasnew;
                                funTmwgj=@(T) dma*0.725*((H2OC(1,1)/(T+273) + H2OC(1,2))*(H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*(ppmj*10^-6)/(1+((H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*(ppmj*10^-6)+(CH4C(1,3)*exp(CH4C(1,4)/(R*(T+273))))*P*(1-(ppmj*10^-6))))+(H2OC(2,1)/(T+273) + H2OC(2,2))*(H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*(ppmj*10^-6)/(1+((H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*(ppmj*10^-6)+ (CH4C(2,3)*exp(CH4C(2,4)/(R*(T+273))))*P*(1-(ppmj*10^-6)))))*18.015/1000-mwaj;
                                equilibT=fzero(funTmwgj,T,Tgasnew);
                                q=(Tadnew-equilibT)*(Cpa*dma+mwgj*CpH2O); %going "back to equilibrium" to iterate on adsorption from there
                                Tadj=equilibT; Tgasj=Tgasnew+(q/(Cpg*Mgasj+CpH2O*mwgj));
                                qmax=q; qbig=0; Tgasmax=Tgasj;
                                [Tgasnew, Tadnew, mwadnew, gasincrease] = adsorbent_temperature_iteration_updated_capacity(Tgasj, Tadj, mwaj, Mgasj, mwgj, dma, q, qbig, mwadp);
                     end
                 
                 elseif mwaj==dma*mwadp(10^-6*ppm(j),Tad(j)) %if we actually are at eguilibrium! (unlikely)
                                qmax=q; qbig=0; Tgasmax=Tgasj;
                                [Tgasnew, Tadnew, mwadnew, gasincrease] = adsorbent_temperature_iteration_updated_capacity(Tgasj, Tadj, mwaj, Mgasj, mwgj, dma, q, qbig, mwadp);                     
                 else %only desorption, no deltaT
                     desorbed=q/hvap;
                     mwadnew=mwaj-desorbed;
                     mwgnew=mwgj+desorbed;
                     Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj));
                     Tadnew=Tadj;
                     ppmnew=(10^6*(mwgnew*MWgas/(Mgas(j)*MWwater)));
                        if isnan(ppmnew)==1 || isinf(ppmnew)==1 || ppmnew==0
                            ppmnew=0.1;
                        end
                     if mwadnew<dma*mwadp(10^-6*ppmj,Tadj) %if the desorption is so that equilibrium is passed
                             T=Tadj; deltam=10^-7*Mgas(j);
                             deltam= fzero(@(deltam) dma*0.725*((H11/(T+273) + H12)*(H13*exp(H14/(R*(T+273))))*P*(((mwgj+deltam)*MWgas/(Mgasj*MWwater)))/(1+((H13*exp(H14/(R*(T+273))))*P*(((mwgj+deltam)*MWgas/(Mgasj*MWwater)))+(C13*exp(C14/(R*(T+273))))*P*(1-(((mwgj+deltam)*MWgas/(Mgasj*MWwater))))))+(H21/(T+273) + H22)*(H23*exp(H24/(R*(T+273))))*P*(((mwgj+deltam)*MWgas/(Mgasj*MWwater)))/(1+((H23*exp(H24/(R*(T+273))))*P*(((mwgj+deltam)*MWgas/(Mgasj*MWwater)))+ (C23*exp(C24/(R*(T+273))))*P*(1-(((mwgj+deltam)*MWgas/(Mgasj*MWwater)))))))*18.015/1000 - (mwaj-deltam), deltam, deltam);
                             mwgj=mwgj+deltam;
                             mwaj=mwaj-deltam;
                             Tgasj=Tgasj-((hvap*deltam)/(Cpg*Mgasj+CpH2O*mwgj));
                             q=q-hvap*deltam; qbig=q;
                             [Tgasnew, Tadnew, mwadnew, gasincrease] = adsorbent_temperature_iteration_updated_capacity(Tgasj, Tadj, mwaj, Mgasj, mwgj, dma, q, qbig, mwadp);
                     end
                 end %if mwgj>0 /else mwgj==0

                %Defining the new values
                deltam=mwa(j)-mwadnew;
                Tgas(j)=Tgasnew;
                Tad(j)=Tadnew;
                mwg(j)=mwg(j)+deltam;
                    if abs(mwg(j))<10^-12
                    	mwg(j)=0; mwgj=0;
                    end
                mwa(j)=mwadnew;
                Hgas(j)=Hgas(j)-q+(deltam*CpH2O*(Tgas(j)-25));
                deltam=0;
                
              elseif q>0.001 && Tgas(j)-Tad(j)>0.5 && Tgas(j)<Tdewf(mwg(j)/Mgas(j)) %only heating
                     Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
                     Tadnew=Tadj+q/(mwaj*CpH2O+dma*Cpa); %new adsorbent temperature calculated from q
                     mwgnew=mwgj;
                     
                                     %Defining the new values
                deltam=mwa(j)-mwadnew;
                Tgas(j)=Tgasnew;
                Tad(j)=Tadnew;
                mwg(j)=mwg(j)+deltam;
                    if abs(mwg(j))<10^-12
                    	mwg(j)=0; mwgj=0;
                    end
                mwa(j)=mwadnew;
                Hgas(j)=Hgas(j)-q+(deltam*CpH2O*(Tgas(j)-25));
                deltam=0;
             elseif q<0 %cooling
        Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
        Tadnew=Tadj+q/(mwaj*CpH2O+dma*Cpa); %new adsorbent temperature calculated from q
             end   
              
% %         else %iteration in the silica gel layer
% %             if Mgasj>0 && abs(q)>0.001
% %                  Twall=Tw(nxw,j);
% %                 [Tgasnew, Tadnew, mwadnew, mwgnew] = Silicagel_iteration(Tgasj,Tadj,mwaj,Mgasj,mwgj,dmaSG,q,mwsg,Tdewf,Twall,Mdewf);
% %                 deltam=mwa(j)-mwadnew;
% %                 Tgas(j)=Tgasnew;
% %                 Tad(j)=Tadnew;
% %                 mwg(j)=mwg(j)+deltam;
% %                     if abs(mwg(j))<10^-12
% %                     	mwg(j)=0; mwgj=0;
% %                     end
% %                 mwa(j)=mwadnew;
% %                 Hgas(j)=Hgas(j)-q+(deltam*CpH2O*(Tgas(j)-25));
% %                 deltam=0;
% %             end
% %        end %end if j<ny-13-7

        else %CB area
            if Mgasj>0
                Tgasnew=Tgasj-(q/(Cpg*Mgasj+CpH2O*mwgj)); %new gas temperature calculated from q
                Tadnew=Tadj+q/mCpCB; %new adsorbent temperature calculated from q
                Tgas(j)=Tgasnew;
                Tad(j)=Tadnew;
            end
        end %end if MS else CB
        
            
    end  %ends "for" in y- direction

    %wall temperature in top layer of column:
    Tw1(:,ny)=Tw(:,ny-1)+(Tw(:,ny-1)-Tw(:,ny-2)); %boundary condition wall: T unchanged out
Tadlast(j)=Tad(j);

Vg(1)=Qm/(Af*densgasinitial);   %velocity of the gas in the first cell
movecells(1)=Vginitial*dtdivdy; %how big part of cell 1 that will "be pushed" upwards
densgas(1)=densgasf(Tgas(1)); %density of gas in first cell

%calculations of gas movements upwards the column
for i=2:ny
    densgas(i)=densgasf(Tgas(i)); %density of gas in cell i
    Vg(i)=Qm/(Af*densgas(i-1));  %speed of cell i. calculated from properties in cell below since this is what "pushes" the gas in cell i upwards
    movecells(i)=Vg(i)*dtdivdy; %how big part of cell i that will "be pushed" upwards
    
    if movecells(i)>1 %if this is the case, you need to check if it might cause problems
        display('error, moving more than one cell per timestep')
        return
    end
    
    movegascells(i)=movecells(i)*Mgas(i); %how much of the mass in cell i that will move upwards
    moveHcells(i)=movecells(i)*Hgas(i); %how much of the energy that will move upwards
    movemwg(i)=movecells(i)*mwg(i);
    
end   

    movegascells(1)=movecells(1)*Mgas(1); %how much of the mass in cell 1 that will move upwards
    moveHcells(1)=movecells(1)*Hgas(1); %how much of the energy in cell 1 that will move upwards
    movemwg(1)=movecells(1)*mwg(1);

for i=2:ny

    Mgas1(i)=Mgas(i)-movegascells(i)+movegascells(i-1);  %mass of the gas within the cell i after it's shifted
    Hgas1(i)=Hgas(i)-moveHcells(i)+moveHcells(i-1); %amount of energy in gas in cell i after it's shifted
    mwg1(i)=mwg(i)-movemwg(i)+movemwg(i-1);
        
        
end
Mgasout=Mgas(ny)-movegascells(ny); Hout=Hgas(ny)-moveHcells(ny);
%waterout=mwg(i)-movemwg(i);
saturationouttime(ceil(minu)) = (mwg(ny))/(Mdewf(Tad(ny))*Mgas(ny));
waterout=movemwg(i); waterouttime(ceil(minu))=waterouttime(ceil(minu))+waterout;
    Mgas1(1)=Mgas(1)-movegascells(1)+Mgasentering;   %amount of gas in cell one after it's shifted
    Hgas1(1)=Hgas(1)-moveHcells(1)+Hgasentering; %amount of energy in gas in cell i after it's shifted
    mwg1(1)=mwg(1)-movemwg(1);
    Mgas=Mgas1; Hgas=Hgas1;
    mwg=mwg1;
    for i=1:ny
        if Mgas(i)< 0.001*Mgasentering %to avoid dividing by a number close to zero
            Tgas(i)=25;
        else
            Tgas(i)=25+(Hgas(i)-(mwg(i)*(Tgas(i)-25)*CpH2O))/(Mgas(i)*Cpg);
        end
    end
    
  %%   
  
  for i=1:ny
      ppm(i)=(10^6*(mwg(i)*MWgas/(Mgas(i)*MWwater)));
      if isnan(ppm(i))==1 || isinf(ppm(i))==1 || ppm(i)==0
          ppm(i)=0.1;
      end      
  end
  ppmouttime(ceil(minu))=ppm(ny);  
      waitbar(t/tmax, wbar, timestep*dt) 
    
    minu=t/60; %Tracking the GAS OUTLET TEMPERATURES

    
    
    if ceil(minu) == floor(minu) && Mgas(ny)>0
    Mgaschanneling=Mgasout+channeling*Qm*dt;
    Hgaschanneling1=Hout+Hgaschanneling;
    Tgaschanneling=25+(Hgaschanneling1-(waterout*(Tgas(ny)-25)*CpH2O))/(Mgaschanneling*Cpg); %Temperature of the exiting gas. included channeling gas (if applicable)
        tout(minu,1)=minu;
        tout(minu,2)=Tgaschanneling;
        
        mgasout2=Mgasout*Qm*dt;
        Hgasout2=Hout+Hgaschanneling;
        Hgasout2=Hgasout2-(mwg(ny)*CpH2O*(Tgas(ny)-25));
        Tgaschanneling2=Tg(Hgasout2/mgasout2);
        tout2(minu,1)=minu;
        tout2(minu,2)=Tgaschanneling2;
        
        
    end   
    
        
       tt=t/60;
    if ceil(tt) == floor(tt) %Creating matrices with temperautre profiles every 10 minutes
        i=t/60;
        heatdistmatrix(:,1,i)=Tgas(:,1);
        heatdistmatrix(:,2,i)=Tad(:,1);
        heatdistmatrix(:,3,i)=Tw(nxw,1:ny);
        
        tempwall(i,1)=i;
        tempwall(i,2)=Tw(nxw,round(0.71*ny/6.3));
        tempwall(i,3)=Tw(nxw,round(1.91*ny/6.3));
        tempwall(i,4)=Tw(nxw,round(2.73*ny/6.3));
        tempwall(i,5)=Tw(nxw,round(3.89*ny/6.3));
        tempwall(i,6)=Tw(nxw,round(4.70*ny/6.3));
        tempwall(i,7)=Tw(nxw,round(5.75*ny/6.3));
        tempwall(i,8)=Tw(nxw,round(6.22*ny/6.3));
        tempwall(i,9)=tout(i,2);
        tempwall(i,10)=Tgasin;
        
        %Bruk Tw(5,.....)
%         for i=2:8
% disp(tempwall(52,i))
% end
%prøv med lavere hwa?!
        
        tempad(i,1)=i;
        tempad(i,2)=Tad(round(0.71*ny/6.3));
        tempad(i,3)=Tad(round(1.91*ny/6.3));
        tempad(i,4)=Tad(round(2.73*ny/6.3));
        tempad(i,5)=Tad(round(3.89*ny/6.3));
        tempad(i,6)=Tad(round(4.70*ny/6.3));
        tempad(i,7)=Tad(round(5.75*ny/6.3));
        tempad(i,8)=Tad(round(6.22*ny/6.3));
        tempad(i,9)=tout(i,2);
        tempad(i,10)=Tgasin;
    end
    

    
end %timestep ends
    % all calculations are done at this stage
    
    close(wbar)         %closes the waitbar
    
    %Creating plot of temperature profile at t=tend
    l=length(Tgas);
    sam=zeros(l,3);             %making a matrix with the adsorbtion, gas and wall temperatures
    sam(1:l,1)=Tgas(1:l,1);
    sam(1:l,2)=Tad(1:l,1);
    sam(1:l,3)=Tw(nxw,:);
    minutes=t/60;
    aaa=(0:(6.3/(ny-1)):6.3);
 plot(aaa, Tad(1:ny), 'r', aaa, Tgas(1:ny), 'g', aaa, Tw((nxw-1),1:ny), 'b' )
 title(['Temperature distribution at ', num2str(minutes),' minutes',', Q=', num2str(Qmh), ' kg/h' ], 'FontWeight','bold')
 xlabel('Position of column [m]')
 ylabel('Temperature [C]');
 legend('Adsorbent','Gas','Wall');
 axis([0 6.3 0 232]);

 %plotting at i*10 minutes
 
      l=length(Tgas);
    sam=zeros(l,3);             %making a matrix with the adsorbtion, gas and wall temperatures
    sam(1:l,1)=Tgas(1:l,1);
    sam(1:l,2)=Tad(1:l,1);
    sam(1:l,3)=Tw(nxw,:);
   minutes=i*1;
   aaa=(0:(6.655/(ny-1-13)):6.655);
 plot(aaa, heatdistmatrix(14:ny,2,i), 'r', aaa, heatdistmatrix(14:ny,1,i), 'g', aaa,  heatdistmatrix(14:ny,3,i), 'b' )
 title(['Temperature distribution at ', num2str(minutes),' minutes'], 'FontWeight','bold', 'Fontsize', 12)
 xlabel('Position of column [m]', 'FontWeight','bold')
 ylabel('Temperature [C]', 'FontWeight','bold');
 legend('Adsorbent','Gas','Wall');
 axis([0 6.655 0 232]);
  set(gcf,'color','w');

mass=0;
for i=1:ny
    mass=mass+Mgas(i);
end
mass=mass+gasout;
total=mass/timestep
Mgasentering
ff=0; hl=0;
for i=1:ny
    ff=ff+free_water(i);
    hl=hl+Energyintot(i);
end
    

 a=size(tempwall);
 tempwall2=25*ones(a(1)+1, 10);
 tempwall2((2:length(tempwall2)),:)=tempwall;
 tempwall=tempwall2;
 
 
 tid=0:1:tmax/60;
 plot(tid, tempwall(:,2), 'r', tid, tempwall(:,3), 'g', tid, tempwall(:,4), 'b', tid, tempwall(:,5), 'y', tid, tempwall(:,6), 'm', tid, tempwall(:,7), 'c', tid, tempwall(:,8),'k', tid, tempwall(:,9), 'r:', tid, tempwall(:,10), 'b:', 'LineWidth',1) 
 title(['Wall temperatures'], 'FontWeight','bold', 'Fontsize', 18)
 xlabel('Time [min]', 'FontWeight','bold')
 ylabel('Temperature [C]', 'FontWeight','bold');
 legend('0.71 m','1.93 m','2.73 m', '3.89 m', '4.70 m', '5.75 m', '6.22 m','Gas out', 'Gas in');
 axis([0 (tmax/60) 0 235]);

 a=size(tempad);
 tempad2=25*ones(a(1)+1, 10);
 tempad2((2:length(tempad2)),:)=tempad;
 tempad=tempad2;

 tid=0:1:tmax/60;
 plot(tid, tempad(:,2), 'r', tid, tempad(:,3), 'g', tid, tempad(:,4), 'b', tid, tempad(:,5), 'y', tid, tempad(:,6), 'm', tid, tempad(:,7), 'c', tid, tempad(:,8),'k', tid, tempad(:,9), 'r:', tid, tempad(:,10), 'b:')% 'Color',1/255*[112 219 147])'Color',1/255*[148 0 211] tid, tempad(:,9), 
 title(['Adsorbent temperatures'], 'FontWeight','bold', 'Fontsize', 18)
 xlabel('Time [min]', 'FontWeight','bold')
 ylabel('Temperature [C]', 'FontWeight','bold');
 legend('0.71 m','1.93 m','2.73 m', '3.89 m', '4.70 m', '5.75 m', '6.22 m','Gas out', 'Gas in');
 axis([0 (tmax/60) 0 235]);
 
 x=1:tmax/60;
 plot(x, condensedtime, 'r',x, evaporatedtime, 'b', x, tout(:,2)./15, 'k')
 title(['Re- condensed and Evaporated Water'], 'FontWeight','bold', 'Fontsize', 18)
 xlabel('Time [min]', 'FontWeight','bold', 'Fontsize', 12)
 ylabel('0.05*Temperature[C] / Water [kg/min]', 'FontWeight','bold', 'Fontsize', 12);
 legend('Re-condensed water','Evaporated water','Tout/15');
 
 set(gcf,'color','w');
 
 condensedtot=0; Energyoutcounter=0; Energyincounter=0; asdf=0; mwatot=0; Hintot;
 for i=1:tmax/60
     condensedtot=condensedtot+condensedtime(i);
 end
 for i=1:ny
     Energyoutcounter=Energyoutcounter+Energyouttot(i);
     Energyincounter=Energyincounter+Energyintot(i);
     asdf=asdf+(Tw1(2,i)-25)*pi()*d*dy*ww*densw*Cpw*0.001;
     mwatot=mwatot+mwa(i);
 end
 format short
 condensedtot, Energyoutcounter, Energyincounter, asdf, mwatot, Hintot
 
 mwapercent=mwa/dma;
 st=zeros(ny,1);
    for i=1:ny
        st(i)=mwa(1-i+ny);
    end
    
    s(:,1)=heatdistmatrix(round((-0.63+0.77)*ny/7.01),3,:);
s(:,2)=heatdistmatrix(round((0.7+0.77)*ny/7.01),3,:);
s(:,3)=heatdistmatrix(round((2.12+0.77)*ny/7.01),3,:);
s(:,4)=heatdistmatrix(round((3.53+0.77)*ny/7.01),3,:);
s(:,5)=heatdistmatrix(round((4.95+0.77)*ny/7.01),3,:);
s(:,6)=heatdistmatrix(round((5.56+0.77)*ny/7.01),3,:);
s(:,7)=heatdistmatrix(round((6.11+0.77)*ny/7.01),3,:);