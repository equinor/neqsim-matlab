%calculate the interfacial tension of methane + n-butane at310.95K and
%108 Bar

pathNeqSim();

system1 = neqsim.thermo.system.SystemPrEos(310.93,108.00);
system1.addComponent('methane',0.736); %mole frac like feed
system1.addComponent('n-butane',0.264);
system1.createDatabase(1);
system1.setMixingRule(2);
system1.useVolumeCorrection(0) %Default value is "1" - use volume correction
TPflash(system1,0); %how to close the report

system1.getInterphaseProperties().setInterfacialTensionModel(1);
system1.initPhysicalProperties();

% todo: this fails
dens1 = system1.getInterphaseProperties().getSurfaceTensionModel(0).getMolarDensity(0);
dens2 = system1.getInterphaseProperties().getSurfaceTensionModel(0).getMolarDensity(1);
zsurf = (system1.getInterphaseProperties().getSurfaceTensionModel(0).getz()).*1e9;
dmudnMatrix = system1.getInterphaseProperties().getSurfaceTensionModel(0).getDmudn2();
% plot density profile at interface

m = 2;
n = 2;
nr = 1;
subplot(m,n,nr);
plot(dens2,dens1); %density methane verus n-butane
xlabel('Mole Density of n-butane:reference componet');
ylabel('Mole Density of methane');
hold on
nr = nr + 1;
subplot(m,n,nr);
plot(zsurf,dens1); %interface thickness verus methane density
xlabel('interface thickness [nm]');
ylabel('Mole Density of butane [mol/m3]');
hold on
nr = nr + 1;
subplot(m,n,nr);
plot(zsurf,dens2); %interface thickness verus butane density
xlabel('interface thickness [nm]');
ylabel('Mole Density of methane [mol/m3]');
hold on

%calculat the interfacial tension
int_tension = system1.getInterphaseProperties().getSurfaceTension(0) %unit of interfacial tension mN\m


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
fprintf(fid,'Interface tension [N/m]=  ');
fprintf(fid,'%6.3f\n',system1.getPhase(0).getDensity());


for n = 1:500
    fprintf(fid,'%3i\t',j);
    fprintf(fid,'Density 1 in interface =  ');
    fprintf(fid,'%6.3f\t',dens1(n));
    fprintf(fid,'Density 2 in interface =  ');
    fprintf(fid,'%6.3f\n',dens2(n));
end

fclose(fid);