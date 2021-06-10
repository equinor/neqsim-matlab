% This example demostrates a flash calculation using the CPA-EoS using a
% a classic mixing rule with composition and temperature dependent kij
fluid1 = thermo('cpa');
fluid1.addComponent('nitrogen',1.0);
fluid1.addComponent('CO2',2.1);
fluid1.addComponent('methane',75.0);
fluid1.addComponent('ethane',7.5);
fluid1.addComponent('propane',4.0);
fluid1.addComponent('i-butane',0.6);
fluid1.addComponent('n-butane',1.0);
fluid1.addComponent('i-pentane',0.6);
fluid1.addComponent('n-pentane',1.0);
fluid1.addTBPfraction('C6',1.3,100.3/1000.0,0.80232);
fluid1.addTBPfraction('C7',0.3,120.3/1000.0,0.8232);

fluid1.addComponent('water',0.7);
fluid1.addComponent('MEG',0.3);
fluid1.setMixingRule('classic-Tx-cpa'); % could also use fluid1.setMixingRule(10);
fluid1.setMultiPhaseCheck(1);

% todo: This line gives lots of java.sql.SQLException: Invalid cursor state - no current row.
fluid1.setHydrateCheck(1);

fluid1.setPressure(100.0,'bara')
fluid1.setTemperature(12.2,'C')

TPflash(fluid1)

hydrateEqTemperature = hydt(fluid1);