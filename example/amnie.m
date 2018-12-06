syst = thermo('electrolyte',280, 1.0);
syst.addComponent('CO2',0.1)
syst.addComponent('MDEA',1.0)
syst.addComponent('water',10.0)

reactionCheck(syst)

j=0
for i = (280:360)
    j=j+1;
    disp 'i',i;
    setTemperature(syst,i);
    pres(j) = bubp(syst);
end

show(syst)
plot([280:360],pres)
xlabel('Temperature [K]')
ylabel('Pressure [bar]')
title('vapour pressure vs. temperature')