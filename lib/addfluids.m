function p = addfluids(fluid1,fluid2)
pathNeqSim();

p = neqsim.thermo.system.SystemInterface.addFluids(fluid1,fluid2);