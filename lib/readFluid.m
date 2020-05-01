function system = readFluid(ID)
system = neqsim.thermo.system.SystemSrkEos(298.0,1.0);
system = system.readObject(ID);
end