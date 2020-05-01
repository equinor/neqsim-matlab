clear all

a = thermo('srk',190,10);
a.addComponent('methane',10.0);
%a.addComponent('ethane',5.0);
a.createDatabase(1);
TPflash(a,1)
k = 0;
temp = 110:5:190;
pres = 1:5:100;

for i = temp
    k = k + 1;
    f = 0;
    for j = pres
        f = f + 1;
        t = density(a,i,j);
        dens(k,f,:) = t;
    end
end
hold off
contourf(pres,temp,dens(:,:,1),40)
hold on
lab = contourc(pres,temp,dens(:,:,1),40)
clabel(lab)