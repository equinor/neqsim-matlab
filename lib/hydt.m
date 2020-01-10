function t = hydt(testSystem)
    if testSystem.doHydrateCheck()==0
        testSystem.setHydrateCheck(1);
    end
    testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
    testFlash.setRunAsThread(1);
    testFlash.hydrateFormationTemperature;
    testFlash.waitAndCheckForFinishedCalculation(100000);
    clear testFlash;
    t = testSystem.getTemperature();