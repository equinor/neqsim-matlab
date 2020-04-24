% Error using thermo (line 32)
% Java exception occurred:
% java.lang.UnsatisfiedLinkError: no test2 in java.library.path
% 
% 	at java.lang.ClassLoader.loadLibrary(ClassLoader.java:1867)
% 
% 	at java.lang.Runtime.loadLibrary0(Runtime.java:870)
% 
% 	at java.lang.System.loadLibrary(System.java:1122)
% 
% 	at neqsim.thermo.util.JNI.GERG2004EOS.<init>(GERG2004EOS.java:69)
% 
% 	at neqsim.thermo.phase.PhaseGERG2004Eos.<init>(PhaseGERG2004Eos.java:20)
% 
% 	at neqsim.thermo.system.SystemGERG2004Eos.<init>(SystemGERG2004Eos.java:40)
% 
% 
% Error in GERG2004 (line 1)
% test = thermo('GERG2004',255.32, 6);

test = thermo('GERG2004',255.32, 6);
test.addComponent('methane', 10.01);
test.addComponent('ethane', 0.099);
test.createDatabase(1);

TPflash(test,0);

test

