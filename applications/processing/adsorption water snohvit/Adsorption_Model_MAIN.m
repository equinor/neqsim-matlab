
clear all
clc
format long
height=6.3; %[m] height of column
d=4.0; % [m] diameter of column
% Making the capacity equation
P=65*10^2; %System pressure
R=8.314;        
CH4C=[348.971 0.542 6.770E-06 13672.210; 348.971 0.542 6.130E-07 20307.220];
H2OC=[-3799.940 18.711 3.580E-07 44140.040;3684.491 -4.450 1.620E-05 45199.990];
C11=CH4C(1,1); C12=CH4C(1,2); C13=CH4C(1,3); C14=CH4C(1,4);
C21=CH4C(2,1); C22=CH4C(2,2); C23=CH4C(2,3); C24=CH4C(2,4);
H11=H2OC(1,1); H12=H2OC(1,2); H13=H2OC(1,3); H14=H2OC(1,4);
H21=H2OC(2,1); H22=H2OC(2,2); H23=H2OC(2,3); H24=H2OC(2,4);
%T is in kelvin, but as it is added 273 in the equation, Centigrades must
%be used
        
%kgH2O/kg adsorbent:
mwadp=@(YH2O,T) 0.725*((H2OC(1,1)/(T+273) + H2OC(1,2))*(H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*YH2O/(1+((H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*YH2O+(CH4C(1,3)*exp(CH4C(1,4)/(R*(T+273))))*P*(1-YH2O)))+(H2OC(2,1)/(T+273) + H2OC(2,2))*(H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*YH2O/(1+((H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*YH2O+ (CH4C(2,3)*exp(CH4C(2,4)/(R*(T+273))))*P*(1-YH2O))))*18.015/1000;
%funT=@(T) 0.725*((H2OC(1,1)/(T+273) + H2OC(1,2))*(H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*YH2O/(1+((H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*YH2O+(CH4C(1,3)*exp(CH4C(1,4)/(R*(T+273))))*P*(1-YH2O)))+(H2OC(2,1)/(T+273) + H2OC(2,2))*(H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*YH2O/(1+((H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*YH2O+ (CH4C(2,3)*exp(CH4C(2,4)/(R*(T+273))))*P*(1-YH2O))))*18.015/1000 - mwapart;
%funT1ppm=@(T) dma*0.725*((H2OC(1,1)/(T+273) + H2OC(1,2))*(H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*10^-6/(1+((H2OC(1,3)*exp(H2OC(1,4)/(R*(T+273))))*P*10^-6+(CH4C(1,3)*exp(CH4C(1,4)/(R*(T+273))))*P*(1-10^-6)))+(H2OC(2,1)/(T+273) + H2OC(2,2))*(H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*10^-6/(1+((H2OC(2,3)*exp(H2OC(2,4)/(R*(T+273))))*P*10^-6+ (CH4C(2,3)*exp(CH4C(2,4)/(R*(T+273))))*P*(1-10^-6))))*18.015/1000;



% Simulation properties
ny=240; %number of height segments
dy=height/ny; %size of each height segment
tmax=60*(585*2+120); %Time of  adsorption
dt=0.075; %size of timestep
timesteps=tmax/dt; %number of timesteps in simulation
dtdivdy=dt/dy; %constant used in cell moving calculations

%adsorbent properties
madsorbent=54000; %[kg] total mass of adsorbent in the column
dma=madsorbent/ny; %[kg] mass adsorbent in one height segment
epsilon=0.38; %packing factor for randomly pored spherical material

xA=(pi()*d^2)/4; %cross sectional area of column
aA=0.62*xA;  %Area the adsobent is filling (poured packing)
Af=xA-aA; %free cross sectional area for the gas to flow



%gas & water properties
MWgas=18.54; %molecular weight of the gas
MWwater=18.02; %molecular weight of water
T_initial=25; %temperature of inlet gas [C]
Mgas_hour= 681400; % [kg/h] flowrate of the feed gas - per hour
Qm=Mgas_hour/3600; % [kg/s] flowrate of the feed gas - per second
Cpgas=2.65; %[kJ/kgK] heat capacity of gas
Mgasentering=Qm*dt; %amount of gas that enters the column each height segment
water_content_gas=730*10^-6; %part water in gas - molar
mwgentering= Mgasentering*water_content_gas*MWwater/MWgas; %initial water content of the gas
densgasf=@(xx) 66.41-0.3261*(xx); %density of gas as a function of temperature
densgasinitial=densgasf(25);
densgas=densgasinitial;
Vginitial=Qm/(Af*densgasinitial);

admax= dma*mwadp(730*10^-6,25);
fourppm=dma*mwadp(4*10^-6,25);
thirtyppm=dma*mwadp(30*10^-6,25);

hvap=4187; %kJ/kg 
dtdivdy=dt/dy; %constant used in calculations

%creating matrices
Mgas=zeros(ny,1); Mgas1=zeros(ny,1); %mass of gas in segiment
format long
mwg=zeros(ny,1); mwg1=zeros(ny,1); mwglast=zeros(ny,1); %mass of water in the gas (in segiment)
format short
mwa=zeros(ny,1); 
ppm=zeros(ny,1); %amount of water in segment- in ppm
minu=1; waterincounter=0;
wbar = waitbar(0,'Please wait...');  %defining the waitbar
format long
%START OF CALCULATIONS

for t=1:timesteps
    minu=t*dt/60;
    if minu<47
        Qm=0.33*Mgas_hour/3600; % [kg/s] flowrate of the feed gas - per second
        Mgasentering=Qm*dt; %amount of gas that enters the column each height segment
        mwgentering= Mgasentering*water_content_gas*MWwater/MWgas; %initial water content of the gas
    else
        Qm=0.5*Mgas_hour/3600; % [kg/s] flowrate of the feed gas - per second
        Mgasentering=Qm*dt; %amount of gas that enters the column each height segment
        mwgentering= Mgasentering*water_content_gas*MWwater/MWgas; %initial water content of the gas        
    end
    
    for i=1:ny
 
        if ppm(i)>0.01 && mwa(i)<admax
            mwgi=mwg(i); mwai=mwa(i);
            ppmi=(10^6*(mwg(i)*MWgas/(Mgas(i)*MWwater)));
            ppmnew=ppmi;
            oneppm=mwgi/ppmnew;
            deltappm=100;
                if mwai+mwgi-4*oneppm<fourppm %mindre, dvs mindre enn 4 ppm i gass
                    ppmmax=4; ppmmin=0;
                    ppmnew=0.5*(ppmmax-ppmmin);
                    while deltappm>0.2
                        if mwai+mwgi-((mwgi*ppmnew)/ppmi)<dma*mwadp(ppmnew*10^-6,25)
                            ppmmax=ppmnew;
                            ppmnew=ppmmax-0.5*(ppmmax-ppmmin);
                        else
                            ppmmin=ppmnew;
                            ppmnew=ppmmin+0.5*(ppmmax-ppmmin);
                        end
                        deltappm=ppmmax-ppmmin;
                    end
                    
                elseif mwai+mwgi-4*oneppm>fourppm && mwai+mwgi-30*oneppm<thirtyppm %mellom 4 og 30 ppm i gass
                    ppmmin=4; ppmmax=30;
                    ppmnew=30-0.5*(ppmmax-ppmmin);
                    while deltappm>1
                        if mwai+mwgi-((mwgi*ppmnew)/ppmi)<dma*mwadp(ppmnew*10^-6,25)
                            ppmmax=ppmnew;
                            ppmnew=ppmmax-0.5*(ppmmax-ppmmin);
                        else
                            ppmmin=ppmnew;
                            ppmnew=ppmmin+0.5*(ppmmax-ppmmin);
                        end
                        deltappm=ppmmax-ppmmin;
                    end
                    
                else %mer enn 30 ppm i gass
                    ppmmax=ppmi; ppmmin=30;
                    ppmnew=ppmi-0.5*(ppmmax-ppmmin);
                    while deltappm>4
                        if mwai+mwgi-((mwgi*ppmnew)/ppmi)<dma*mwadp(ppmnew*10^-6,25)
                            ppmmax=ppmnew;
                            ppmnew=ppmmax-0.5*(ppmmax-ppmmin);
                        else
                            ppmmin=ppmnew;
                            ppmnew=ppmmin+0.5*(ppmmax-ppmmin);
                        end
                        deltappm=ppmmax-ppmmin;
                    end
                    
                end
               
                if ppmnew<ppmi
            adsorbed_uncorrected=mwgi*(1-(ppmnew/ppmi)); %new amount of water in gas
            adsorbed=adsorbed_uncorrected*0.15;
           
            mwa(i)=mwa(i)+adsorbed; %new amount of water in gas
            mwg(i)=mwg(i)-adsorbed; %new amount of water in adsorbent  
                end
        end
    end %end for i=1:ny
    
   
    % DEFINING THE INLET GAS SPEED AND H VALUE
Vg=Qm/(Af*densgasinitial);   %velocity of the gas in the first cell
movecells(1)=Vginitial*dtdivdy; %how big part of cell 1 that will "be pushed" upwards

%calculations of gas movements upwards the column
for i=2:ny
    Vg=Qm/(Af*densgas);  %speed of cell i. calculated from properties in cell below since this is what "pushes" the gas in cell i upwards
    movecells(i)=Vg*dtdivdy; %how big part of cell i that will "be pushed" upwards
    
    if movecells(i)>1 %if this is the case, you need to check if it might cause problems
        display('error, moving more than one cell per timestep')
        return
    end
    
    movegascells(i)=movecells(i)*Mgas(i); %how much of the mass in cell i that will move upwards
    movemwg(i)=movecells(i)*mwg(i);
    
end   

    movegascells(1)=movecells(1)*Mgas(1); %how much of the mass in cell 1 that will move upwards
    movemwg(1)=movecells(1)*mwg(1);

for i=2:ny

    Mgas1(i)=Mgas(i)-movegascells(i)+movegascells(i-1);  %mass of the gas within the cell i after it's shifted
    mwg1(i)=mwg(i)-movemwg(i)+movemwg(i-1);
                
end

    Mgas1(1)=Mgas(1)-movegascells(1)+Mgasentering;   %amount of gas in cell one after it's shifted
    mwg1(1)=mwg(1)-movemwg(1)+mwgentering;
    Mgas=Mgas1;
    mwg=mwg1;
    waterincounter=waterincounter+mwgentering;
    for i=1:ny
        if mwg(i)>0.05*10^-6
         ppm(i)=(10^6*(mwg(i)*MWgas/(Mgas(i)*MWwater)));
        else
            mwg(i)=0; ppm(i)=0;
        end
    end
   
    waitbar(t/timesteps, wbar, t*dt) 
end %timestep ends
    % all calculations are done at this stage
    close(wbar)         %closes the waitbar
    
    %Creating plot of temperature profile at t=tend
    mwamass=mwa/dma;
    minutes=t*dt/60;
    l=length(mwa);  
    x=0:height/(l-1):height;
    
    figure
    [AX,H1,H2]=plotyy(x,ppm,x,mwamass, 'plot');
    set(get(AX(1), 'Ylabel'),'String','Water in gas phase [ppm]',  'FontWeight', 'bold', 'FontSize', 14 );
    set(get(AX(2), 'Ylabel'),'String','mwamass',  'FontWeight', 'bold');
    axes(AX(1));
%range([0 800]);
    axes(AX(2));
ylabel(' Water in adsorbent wt%',  'FontWeight', 'bold', 'FontSize', 14)
    xlabel('Column position [m]', 'FontWeight', 'bold', 'FontSize', 14);
    title(['Column water content at end of adsorption '], 'FontWeight', 'bold', 'FontSize', 14)
    set(gcf,'color','w');
    
tt=zeros(ny,1);
    for i=1:ny
        tt(i)=mwa(1-i+ny);
    end
    
    residualwater=0;
for i=1:ny
residualwater=residualwater+mwa(i);
end