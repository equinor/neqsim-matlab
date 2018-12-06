function testSystem = PHflash(testSystem, display)
    if nargin==1
        display=1
    end
    testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
    testFlash.PHflash(testSystem.getEnthalpy(),0);
    if display==1
        testFlash.displayResult;
    end
    clear testFlash;
    testSystem;