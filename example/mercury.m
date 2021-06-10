pathNeqSim();

fluid1 = neqsim.thermo.system.SystemSrkEos(288.15,2.0);
fluid1.addComponent("methane",91.0);
fluid1.addComponent("c-hexane",10.0);
fluid1.addComponent("mercury",1.0);
fluid1.setMixingRule(2);
fluid1.setMultiPhaseCheck(true);

TPflash(fluid1)