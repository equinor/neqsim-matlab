%calculate the interfacial tension of methane + n-butane at310.95K and
%108 Bar
clear all

system1 = neqsim.thermo.system.SystemSrkEos(310.95,108.00);
system1.addComponent('methane',0.736); %mole frac like feed
system1.addComponent('n-butane',0.264);
system1.createDatabase(1);
system1.setMixingRule(2);
system1.useVolumeCorrection(0) %Default value is "1" - use volume correction
TPflash(system1); %how to close the report

%check bulk phase density of mixture
system1.getPhase(0).getDensity();
system1.getPhase(1).getDensity();

%%calculate the phase mole density for each comp. Get molar density 0 -gas;1- liquid;0- methane; 1-n-butabe(mol/m-3)
%unit of Molar volume *e5 m-3
den_vap_liqht = 1e5*system1.getPhase(0).getComponent(0).getx()/system1.getPhase(0).getMolarVolume();
den_vap_ref = 1e5*system1.getPhase(0).getComponent(1).getx()/system1.getPhase(0).getMolarVolume();
den_liq_liqht = 1e5*system1.getPhase(1).getComponent(0).getx()/system1.getPhase(1).getMolarVolume();
den_liq_ref = 1e5*system1.getPhase(1).getComponent(1).getx()/system1.getPhase(1).getMolarVolume();

%equlibrium state properties: mu-chemical potential
volume_vapor_ini = system1.getPhase(0).getTotalVolume();
t_ini = system1.getTemperature();
pressure_equi = 1e5*system1.getPressure(); %change unit to pascal
for i = 1:2
    mu_equi(i) = system1.getPhase(0).getComponent(i-1).getChemicalPotential(system1.getTemperature(),system1.getPressure()); %get chemical potential from vapor phase for both comp
    dmudn_equi(1,i) = system1.getPhase(0).getComponent(0).getChemicalPotentialdN(i-1,system1.getPhase(0));
    dmudn_equi(2,i) = system1.getPhase(0).getComponent(1).getChemicalPotentialdN(i-1,system1.getPhase(0));
    dmudv_equi(i) = 1e5*system1.getPhase(0).getComponent(i-1).getChemicalPotentialdV(system1.getPhase(0));
end

%output the composition,volume and density into data_check.txt
fid = fopen('data_check.txt','wt');
fprintf(fid,'X= ');
fprintf(fid,'%6.4f %6.4f\n',system1.getPhase(1).getComponent(0).getx(),system1.getPhase(1).getComponent(1).getx());
fprintf(fid,'Y= ');
fprintf(fid,'%6.4f %6.4f\n',system1.getPhase(0).getComponent(0).getx(),system1.getPhase(0).getComponent(1).getx());
fprintf(fid,'Molar Volume in liquid phase [Mol/m-3]*10^5=  ');
fprintf(fid,'%6.8f\n',system1.getPhase(1).getMolarVolume());
fprintf(fid,'Molar Volume in vapor phase [Mol/m-3]*10^5=  ');
fprintf(fid,'%6.8f\n',system1.getPhase(0).getMolarVolume());
fprintf(fid,'Mass Density in liquid phase [Kg/m-3]=  ');
fprintf(fid,'%6.3f\n',system1.getPhase(1).getDensity());
fprintf(fid,'Mass Density in vapor phase [Kg/m-3]=  ');
fprintf(fid,'%6.3f\n',system1.getPhase(0).getDensity());
fprintf(fid,'Mole Density in liquid phase [Mol/m-3]=  ');
fprintf(fid,'%6.3f\t %6.3f\n',den_liq_liqht,den_liq_ref);
fprintf(fid,'Mole Density in vopor phase [Mol/m-3]=  ');
fprintf(fid,'%6.3f\t %6.3f\n',den_vap_liqht,den_vap_ref);

%calculate the a and b paramter for vt srk eos according paper lin_duan_2007
gas_constant = neqsim.thermo.ThermodynamicConstantsInterface.R; %Gas constant
NA = neqsim.thermo.ThermodynamicConstantsInterface.avagadroNumber; %avogadro constant
for i = 1:2
    omega(i) = system1.getPhase(0).getComponent(i-1).getAcentricFactor();
    zc(i) = system1.getPhase(0).getComponent(i-1).getCriticalCompressibilityFactor();
    tc(i) = system1.getPhase(0).getComponent(i-1).getTC();
    pc(i) = 1e+5*system1.getPhase(0).getComponent(i-1).getPC(); %change pc unit to pascal
end
for i = 1:2
    m_par(i) = 0.480 + 1.574*omega(i) - 0.176*omega(i).^2;
    alfa(i) = (1 + m_par(i)*(1 - (t_ini/tc(i)).^0.5)).^2;
    a_par(i) = 0.42748*gas_constant.^2*tc(i).^2*alfa(i)/pc(i); % paramter a is from vt srk eos
    b_par(i) = 0.08664*gas_constant*tc(i)/pc(i); % paramter a is from vt srk eos
    tr(i) = 1 - t_ini/tc(i);
end
tr(1) = 0.5; %reduced temperature for methane is constant 0.5 because the methane is under supercritical condition, T>>Tcritical

%calculate the influence paramter for vt srk eos according paper lin_duan_2007
%k_infl_0=[-1.161,-1.571];k_infl_1=[-0.698,-0.840];k_infl_2=[-0.098,-0.143];
for i = 1:2
    k_infl_0(i) = -3.471 + 4.927*zc(i) + 13.085*zc(i).^2 - 2.067*omega(i) + 1.891*omega(i).^2;
    k_infl_1(i) = -1.690 + 2.311*zc(i) + 5.644*zc(i).^2 - 1.027*omega(i) + 1.424*omega(i).^2;
    k_infl_2(i) = -0.318 + 0.299*zc(i) + 1.710*zc(i).^2 - 0.174*omega(i) + 0.157*omega(i).^2;
    k_infl(i) = a_par(i)*(b_par(i).^(2/3))*exp(k_infl_0(i)+k_infl_1(i)*log(tr(i))+k_infl_2(i)*(log(tr(i))).^2)/(NA.^(8/3));
end

ite_step = 500; %iteration step between liquid and vapor phase. the interface is divided into 500 grid
j = 1; %matlab start from 1, not 0. 1 is start point at vapor phase, 500 is liquid phase
del_den_2 = (den_liq_ref - den_vap_ref)/(ite_step - 1); %divide density of reference comp 2 into 500 step. the density of comp 2 is changed linearly.
den_ref = den_vap_ref; %initial reference density: density comp.2 in vapor phase
err_den_2 = 1.d0;
den_interface_1 = den_vap_liqht; % initial density : density of comp.1 in vapor phase
pre_inter_old = pressure_equi;

system2 = neqsim.thermo.system.SystemSrkEos(310.95,108.000);
system2.addComponent('methane',den_vap_liqht/1e5);
system2.addComponent('n-butane',den_vap_ref/1e5);
system2.setMixingRule(2);
system2.useVolumeCorrection(0);
system2.init(0);
system2.setNumberOfPhases(1); % we have 2 phases, why
system2.setUseTVasIndependentVariables(1);
system2.getPhase(0).setTotalVolume(1.0); %?? we need to set total system volume at interface as 1m-3; not vapor phase volume, unit of volume

del_den_interface_1 = 0.0;

%create system for newton iteration
system_newton = neqsim.thermo.system.SystemSrkEos(310.95,108.000);
system_newton.addComponent('methane',den_vap_liqht/1e5);
system_newton.addComponent('n-butane',den_vap_ref/1e5);
system_newton.setMixingRule(2);
system_newton.useVolumeCorrection(0);
system_newton.init(0);
system_newton.setNumberOfPhases(1); % we have 2 phases, why
system_newton.setUseTVasIndependentVariables(1);
system_newton.getPhase(0).setTotalVolume(1.0); %?? we need to set total system volume at interface as 1m-3; not vapor phase volume, unit of volume

while (abs(err_den_2) > 1e-6)
    j = j + 1;
    den_ref(j) = den_ref(j-1) + del_den_2; % density of comp 2 at interface
    %suppose the volume at interface is 1 unit.
    system2.addComponent('methane',del_den_interface_1/1e5);
    system2.addComponent('n-butane',del_den_2/1e5);
    system2.init_x_y();
    system2.init(3);
    
    for i = 1:2
        mu_inter(i) = system2.getPhase(0).getComponent(i-1).getChemicalPotential(system2.getTemperature(),system2.getPhase(0).getPressure());
        dmudn(1,i) = system2.getPhase(0).getComponent(0).getChemicalPotentialdNTV(i-1,system2.getPhase(0));
        dmudn(2,i) = system2.getPhase(0).getComponent(1).getChemicalPotentialdNTV(i-1,system2.getPhase(0));
        dmudv(i) = 1e5*system2.getPhase(0).getComponent(i-1).getChemicalPotentialdV(system2.getPhase(0));
        dpdn(i) = -dmudv(i);
    end
    
    pre_inter_new = 1e5*system2.getPhase(0).getPressure();
    dpdv = 1e10*system2.getPhase(0).getdPdVTn(); %perhaps dpdv= - system2.getPhase(0).getdPdTVn()
    dn2dv = (pre_inter_new - pre_inter_old) - ((dpdv + dpdn(1)*den_interface_1(j - 1))/dpdn(2));
    
    d_mu_1_d_den_2 = (dmudv(1) + dmudn(1,1)*den_interface_1(j - 1) + dmudn(1,2)*dn2dv)/(dn2dv - den_ref(j));
    d_mu_2_d_den_2 = (dmudv(2) + dmudn(2,1)*den_interface_1(j - 1) + dmudn(2,2)*dn2dv)/(dn2dv - den_ref(j));
    
    dn1dv = (pre_inter_new - pre_inter_old) - ((dpdv + dpdn(2)*den_ref(j))/dpdn(1));
    d_mu_1_d_den_1 = (dmudv(1) + dmudn(1,1)*dn1dv + dmudn(1,2)*den_ref(j))/(dn1dv - den_interface_1(j - 1));
    d_mu_2_d_den_1 = (dmudv(2) + dmudn(2,1)*dn1dv + dmudn(2,2)*den_ref(j))/(dn1dv - den_interface_1(j - 1));
    
    d_den1_d_den2(j-1) = (sqrt(k_infl(2))*d_mu_1_d_den_2 - sqrt(k_infl(1))*d_mu_2_d_den_2)/ ...
        (sqrt(k_infl(1))*d_mu_2_d_den_1 - sqrt(k_infl(2))*d_mu_1_d_den_1);
    
    %initial valve of density of comp.1 at interface
    den_interface_1(j) = den_interface_1(j-1) + d_den1_d_den2(j-1)*del_den_2;
    
    %find delta density 1  by using newton raphson to slove object function
    newton_inter
    den_interface_1(j) = den1_inter_new; %den1_inter_new from newton raphson
    del_den_interface_1 = den_interface_1(j) - den_interface_1(j-1);
    
    %den_interface_1(j)
    %when density of ref comp 2 equals to liquid density of comp2,stop.
    err_den_2 = den_ref(j) - den_liq_ref;
    fprintf(fid,'%3i\t',j);
    fprintf(fid,'Density 1 in interface =  ');
    fprintf(fid,'%6.3f\t',den_interface_1(j));
    fprintf(fid,'Density 2 in interface =  ');
    fprintf(fid,'%6.3f\n',den_ref(j));
end

%using number density to calculate the new d_den1_d_den2 + kappa + pressure difference for each grid
%equilibrium phase property has to be calculated by input number density
system_NA_equi = neqsim.thermo.system.SystemSrkEos(310.95,108.000);
system_NA_equi.addComponent('methane',den_vap_liqht/1e5);
system_NA_equi.addComponent('n-butane',den_vap_ref/1e5);
system_NA_equi.setMixingRule(2);
system_NA_equi.useVolumeCorrection(0);
system_NA_equi.init(0);
system_NA_equi.setNumberOfPhases(1); % we have 2 phases, why
system_NA_equi.setUseTVasIndependentVariables(1);
system_NA_equi.getPhase(0).setTotalVolume(1.0); %?? we need to set total system volume at interface as 1m-3; not vapor phase volume, unit of volume
system_NA_equi.init_x_y();
system_NA_equi.init(3);

pressure_equi = 1e5*system_NA_equi.getPhase(0).getPressure(); %change unit to pascal
for i = 1:2
    mu_equi(i) = system_NA_equi.getPhase(0).getComponent(i-1).getChemicalPotential(system_NA_equi.getTemperature(),system_NA_equi.getPhase(0).getPressure()); %get chemical potential from vapor phase for both comp
end
pre_inter_old = pressure_equi;
% den_ref_na=den_ref*NA;
% den_interface_1_na=den_interface_1*NA;

for j = 1:500
    system_NA(j) = neqsim.thermo.system.SystemSrkEos(310.95,108.00);
    system_NA(j).addComponent('methane',den_interface_1(j)/1e5);
    system_NA(j).addComponent('n-butane',den_ref(j)/1e5);
    system_NA(j).setMixingRule(2);
    system_NA(j).useVolumeCorrection(0);
    system_NA(j).init(0);
    system_NA(j).setNumberOfPhases(1); % we have 2 phases, why
    system_NA(j).setUseTVasIndependentVariables(1);
    system_NA(j).getPhase(0).setTotalVolume(1); %?? we need to set total system volume at interface as 1m-3; not vapor phase volume, unit of volume
    system_NA(j).init_x_y();
    system_NA(j).init(3);
    % system_NA(j).getPhase(0).getPressure()
    % pause
    
    for i = 1:2
        mu_inter(i) = system_NA(j).getPhase(0).getComponent(i-1).getChemicalPotential(system_NA(j).getTemperature(),system_NA(j).getPhase(0).getPressure());
        dmudn(1,i) = system_NA(j).getPhase(0).getComponent(0).getChemicalPotentialdNTV(i-1,system_NA(j).getPhase(0));
        dmudn(2,i) = system_NA(j).getPhase(0).getComponent(1).getChemicalPotentialdNTV(i-1,system_NA(j).getPhase(0));
        dmudv(i) = 1e5*system_NA(j).getPhase(0).getComponent(i-1).getChemicalPotentialdV(system_NA(j).getPhase(0));
        dpdn(i) = -dmudv(i);
    end
    
    pre_inter_new = 1e5*system_NA(j).getPhase(0).getPressure();
    dpdv = 1e10*system_NA(j).getPhase(0).getdPdVTn(); %perhaps dpdv= - system(j).getPhase(0).getdPdTVn()
    dn2dv = (pre_inter_new - pre_inter_old) - ((dpdv + dpdn(1)*den_interface_1(j))/dpdn(2));
    
    
    d_mu_1_d_den_2 = (dmudv(1) + dmudn(1,1)*den_interface_1(j) + dmudn(1,2)*dn2dv)/(dn2dv - den_ref(j));
    d_mu_2_d_den_2 = (dmudv(2) + dmudn(2,1)*den_interface_1(j) + dmudn(2,2)*dn2dv)/(dn2dv - den_ref(j));
    
    dn1dv = (pre_inter_new - pre_inter_old) - ((dpdv + dpdn(2)*den_ref(j))/dpdn(1));
    d_mu_1_d_den_1 = (dmudv(1) + dmudn(1,1)*dn1dv + dmudn(1,2)*den_ref(j))/(dn1dv - den_interface_1(j));
    d_mu_2_d_den_1 = (dmudv(2) + dmudn(2,1)*dn1dv + dmudn(2,2)*den_ref(j))/(dn1dv - den_interface_1(j));
    
    d_den1_d_den2_na(j) = (sqrt(k_infl(2))*d_mu_1_d_den_2 - sqrt(k_infl(1))*d_mu_2_d_den_2)/ ...
        (sqrt(k_infl(1))*d_mu_2_d_den_1 - sqrt(k_infl(2))*d_mu_1_d_den_1);
    
    kappa(j) = k_infl(1)*d_den1_d_den2_na(j).^2 + 2*sqrt(k_infl(1)*k_infl(2))*d_den1_d_den2_na(j) + k_infl(2);
    pre_differ(j) = pre_inter_new - pressure_equi;
    %mu_times_den(j)=den_interface_1_na(j)*(mu_inter(1)-mu_equi(1))+den_ref_na(j)*(mu_inter(2)-mu_equi(2))-pre_differ(j);
    mu_times_den(j) = den_interface_1(j)*(mu_inter(1) - mu_equi(1)) + den_ref(j)*(mu_inter(2) - mu_equi(2)) - pre_differ(j);
    kappa(j)
    mu_times_den(j)
    pause(0.1)
    ift_integer_obj(j) = sqrt(2*kappa(j)*mu_times_den(j))*del_den_2*NA;
    
    if (j == 1)
        z_interger_obj = 0.d0; % z equal density of comp 2=vap density
    else
        z_interger_obj(j) = z_interger_obj(j-1) + sqrt(kappa(j)/(2*(mu_times_den(j))))*del_den_2*NA*1e9;
    end
    pre_inter_old = pre_inter_new;
end

% plot density profile at interface
m = 2;
n = 2;
nr = 1;
subplot(m,n,nr);
plot(den_ref,den_interface_1); %density methane verus n-butane
xlabel('Mole Density of n-butane:reference componet');
ylabel('Mole Density of methane');
hold on
nr = nr + 1;
subplot(m,n,nr);
plot(z_interger_obj,den_ref); %interface thickness verus methane density
xlabel('interface thickness [nm]');
ylabel('Mole Density of butane [mol/m3]');
hold on
nr = nr + 1;
subplot(m,n,nr);
plot(z_interger_obj,den_interface_1); %interface thickness verus butane density
xlabel('interface thickness [nm]');
ylabel('Mole Density of methane [mol/m3]');
hold on

%calculat the interfacial tension
int_tension = sum(ift_integer_obj)*1e3 %unit of interfacial tension mN\m
fclose(fid);