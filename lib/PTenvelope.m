function testFlash = PTenvelope(testSystem)
    testSystem.init(0)
    testSystem.init(1)
    testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
    testFlash.calcPTphaseEnvelope(1);
    testFlash.displayResult();
    return;
     