%use newton rapson method to find new density of component 1 at interface

del_den_err = 1.d0;
den1_inter_old = den_interface_1(j);
pre_inter_old = 1e5*system2.getPhase(0).getPressure();

%   system_newton= SystemSrkEos(310.95,108.000);
%   system_newton.addComponent('methane',  den_interface_1(j-1)/1e5);
%   system_newton.addComponent('n-butane', den_vap_ref/1e5+j*del_den_2/1e5);
%   system_newton.setMixingRule(2);
%   system_newton.useVolumeCorrection(0);
%   system_newton.init(0);
%   system_newton.setNumberOfPhases(1); % we have 2 phases, why
%   system_newton.setUseTVasIndependentVariables(1);
%   system_newton.getPhase(0).setTotalVolume(1.0); %?? we need to set total system volume at interface as 1m-3; not vapor phase volume, unit of volume

del_den_interface_1 = den_interface_1(j) - den_interface_1(j-1);
system_newton.addComponent('n-butane',del_den_2/1e5);

while (abs(del_den_err) > 1e-5)
    system_newton.addComponent('methane',del_den_interface_1/1e5);
    %system_newton.addComponent('n-butane', j*del_den_2/1e5);
    system_newton.init_x_y();
    system_newton.init(3);
    
    for i = 1:2
        mu_inter(i) = system_newton.getPhase(0).getComponent(i-1).getChemicalPotential(system_newton.getTemperature(),system_newton.getPhase(0).getPressure());
        dmudn(1,i) = system_newton.getPhase(0).getComponent(0).getChemicalPotentialdNTV(i-1,system_newton.getPhase(0));
        dmudn(2,i) = system_newton.getPhase(0).getComponent(1).getChemicalPotentialdNTV(i-1,system_newton.getPhase(0));
        dmudv(i) = 1e10*system_newton.getPhase(0).getComponent(i-1).getChemicalPotentialdV(system_newton.getPhase(0));
        dpdn(i) = -dmudv(i);
    end
    
    pre_inter_new = 1e5*system_newton.getPhase(0).getPressure(); %perhaps it is pascal here
    dpdv = 1e10*system_newton.getPhase(0).getdPdVTn(); %perhaps dpdv= - system2.getPhase(0).getdPdTVn()
    
    dn1dv = (pre_inter_new - pre_inter_old) - ((dpdv) + dpdn(2)*den_ref(j))/dpdn(1);
    
    %find delta density 1  by using newton raphson to slove object function
    f_obj = -(sqrt(k_infl(2))*(mu_inter(1) - mu_equi(1)) - sqrt(k_infl(1))*(mu_inter(2) - mu_equi(2))); %check change negative
    d_f_obj_dv = -sqrt(k_infl(2))*(dmudv(1) - dmudv_equi(1)) + sqrt(k_infl(1))*(dmudv(2) - dmudv_equi(2));
    d_f_obj_dn1 = -sqrt(k_infl(2))*(dmudn(1,1) - dmudn_equi(1,1)) + sqrt(k_infl(1))*(dmudn(2,1) - dmudn_equi(2,1));
    d_f_obj_dn2 = -sqrt(k_infl(2))*(dmudn(1,2) - dmudn_equi(1,2)) + sqrt(k_infl(1))*(dmudn(2,2) - dmudn_equi(2,2));
    
    d_f_obj_d_den1 = (d_f_obj_dv + d_f_obj_dn1*dn1dv + d_f_obj_dn2*den_ref(j))/ ...
        (dn1dv - den1_inter_old); %  check change negative
    
    den1_inter_new = den1_inter_old - f_obj/d_f_obj_d_den1;
    del_den_interface_1 = den1_inter_new - den1_inter_old;
    del_den_err = den1_inter_new - den1_inter_old;
    den1_inter_old = den1_inter_new;
    pre_inter_old = pre_inter_new;
    
end