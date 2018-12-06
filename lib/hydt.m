function t = hydt(testSystem)
    testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
    testFlash.setRunAsThread(1);
    testFlash.hydrateFormationTemperature;
    testFlash.waitAndCheckForFinishedCalculation(100000);
    clear testFlash;
    t = testSystem.getTemperature();