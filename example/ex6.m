hold on

syst = thermo('srk',190,0.01);
syst.addComponent('methane',10.0);
syst.addComponent('ethane',10.0);
syst.createDatabase(1);
syst.setMixingRule(2)

j = 0
for i = (80:200)
    j = j + 1
    disp 'i',i
    a = density(syst,i)
    dens(j) = a(1)
end

plot([80:200],dens)