function fluid = flash(fluid, flashtype, spec1, spec2, unitspec1, unitspec2)
    testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(fluid);
    testFlash.flash(flashtype, spec1, spec2, unitspec1, unitspec2);
    fluid.initProperties();
    clear testFlash;
    fluid;