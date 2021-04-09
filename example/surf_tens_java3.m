%calculate the interfacial tension of methane + n-butane at310.95K and
%108 Bar
%reference comp. : highest boiling point
pathNeqSim();

system1 = neqsim.thermo.system.SystemPrEos(310.95,108); %
system1.addComponent('methane',0.8); %mole frac like feed
system1.addComponent('n-butane',0.2);
system1.createDatabase(1);
system1.setMixingRule(2);
system1.useVolumeCorrection(1) %Default value is "1" - use volume correction
TPflash(system1,0); %how to close the report

system1.getInterphaseProperties().setInterfacialTensionModel(1); % GT == 1  Parac==0 LGT==2
system1.initPhysicalProperties();

% if (system1.getNumberOfPhases()>1)
%     dens1 = system1.getInterphaseProperties().getSurfaceTensionModel(0).getMolarDensity(0);
%     dens2 = system1.getInterphaseProperties().getSurfaceTensionModel(0).getMolarDensity(1);
%     zsurf = (system1.getInterphaseProperties().getSurfaceTensionModel(0).getz()).*1e9;
%
%     int_tension=1e3*system1.getInterphaseProperties().getSurfaceTension(0);%unit of interfacial tension mN\m
%
%     m=2;
%     n=2;
%     nr=1;
%     subplot(m,n,nr);
%     plot(dens2 , dens1); %density methane verus n-butane
%     xlabel('Mole Density of reference componet');
%     ylabel('Mole Density ');
%     hold on
%     nr=nr+1;
%     subplot(m,n,nr);
%     plot(zsurf, dens1,'color','r'); %interface thickness verus methane density
%     xlabel('interface thickness [nm]');
%     ylabel('Mole Density [mol/m3]');
%     hold on
%     plot(zsurf,dens2);%interface thickness verus butane density
%     hold on
%
%     %output the composition,volume and density into data_check.txt
%     fid = fopen('data_check.txt', 'wt');fprintf(fid, 'X= ');fprintf(fid, '%6.4f %6.4f\n',system1.getPhase(1).getComponent(0).getx(),system1.getPhase(1).getComponent(1).getx());
%     fprintf(fid, 'Y= ');fprintf(fid, '%6.4f %6.4f\n',system1.getPhase(0).getComponent(0).getx(),system1.getPhase(0).getComponent(1).getx());
%     fprintf(fid,'Mass Density in liquid phase [Kg/m-3]=  ');fprintf(fid, '%6.3f\n', system1.getPhase(1).getDensity());
%     fprintf(fid,'Mass Density in vapor phase [Kg/m-3]=  '); fprintf(fid, '%6.3f\n', system1.getPhase(0).getDensity());
%     fprintf(fid,'Interface tension [mN/m]=  '); fprintf(fid, '%6.3f\n', system1.getPhase(0).getDensity());
%
%     for n= 1:500
%     fprintf(fid, '%3i\t', j);fprintf(fid,'Density 1 in interface =  ');fprintf(fid, '%6.3f\t',  dens1(n));
%     fprintf(fid,'Density 2 in interface =  ');fprintf(fid, '%6.3f\n',  dens2(n));
%     end
%     fclose(fid);
%
% else
%     disp('only one phase');
% end
j = 0;
pressure_ini = 1.0; %plot pressure verus interfacial tension
for i = 1:310
    pressure2(i) = pressure_ini + i*0.5;
    system1.setPressure(pressure2(i));
    system1.init;
    TPflash(system1,0);
    if (system1.getNumberOfPhases() > 1)
        system1.initPhysicalProperties();
        % dens1 =
        % system1.getInterphaseProperties().getSurfaceTensionModel(0).getMolarDensity(0);
        % dens2 = system1.getInterphaseProperties().getSurfaceTensionModel(0).getMolarDensity(1);
        % zsurf = (system1.getInterphaseProperties().getSurfaceTensionModel(0).getz()).*1e9;
        % plot density profile at interface
        j = j + 1;
        pressure(j) = pressure_ini + i*0.5;
        % todo: this fails
        int_tension(j) = 1e3*system1.getInterphaseProperties().getSurfaceTension(0); %unit of interfacial tension mN\m
    else
        disp('only one phase');
    end
end
plot(pressure,int_tension);
hold on
%system1