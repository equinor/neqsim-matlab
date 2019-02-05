function testSystem = PSflash(testSystem, entropy, display)
    if nargin==2
        display=1
    end
    testFlash = neqsim.thermodynamicOperations.ThermodynamicOperations(testSystem);
    testFlash.PSflash(entropy);
    if display==1
        testFlash.displayResult;
    end
    clear testFlash;
    testSystem;