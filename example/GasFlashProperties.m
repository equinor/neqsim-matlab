% Verification of NeqSim for gas 1
components = ["water"; "nitrogen"; "CO2"; "H2S"; "methane"; "ethane"; "propane"; "i-butane"; "n-butane"; "i-pentane"; "n-pentane"; "n-hexane"];
fractions1 = [2.18, 0.48, 1.77, 0, 62.88, 12.36, 9.58, 2.21, 2.47, 0.98, 0.46, 4.63];
fractions2 = [0.054, 0.454, 1.514, 0, 89.92, 5.324, 1.535, 0.232, 0.329, 0.094, 0.107, 0.437];
P_bar = [1, 10, 100, 200, 1, 10, 100, 200, 1, 10, 100, 200];
T_C = [15, 15, 15, 15, 30, 30, 30, 30, 150, 150, 150, 150];

fluid = thermo('srk',298,10);
for c = 1:numel(components)
    fluid.addComponent(components(c),fractions1(c));
end

fluid.setMixingRule(2);
fluid.setMultiPhaseCheck(1);

% be careful not to overload (replace) functions with variables
enthalpy_ = zeros(1,12);
entropy = zeros(1,12);
numberOfPhases = zeros(1,12);
mixMolarVolume = zeros(1,12);
mixDensity = zeros(1,12);
mixZfactor = zeros(1,12);
mixEnthalpy = zeros(1,12);
mixEntropy = zeros(1,12);
mixCp = zeros(1,12);
mixCv = zeros(1,12);
mixKappa = zeros(1,12);
mixViscosity = zeros(1,12);
mixThermalConductivity = zeros(1,12);

gasFractionc = zeros(1,12);
gasMolarVolume = zeros(1,12);
gasVolumeFraction = zeros(1,12);
gasWtFraction = zeros(1,12);
gasDensity = zeros(1,12);
gasZ = zeros(1,12);
gasKappa = zeros(1,12);
gasMolarMass = zeros(1,12);
gasEnthalpy = zeros(1,12);
gasViscosity = zeros(1,12);
gasThermalConductivity = zeros(1,12);
gasSoundSpeed = zeros(1,12);
gasJouleThomsonCoefficient = zeros(1,12);

oilFractionc = zeros(1,12);
oilMolarVolume = zeros(1,12);
oilVolumeFraction = zeros(1,12);
oilWtFraction = zeros(1,12);
oilDensity = zeros(1,12);
oilZ = zeros(1,12);
oilKappa = zeros(1,12);
oilMolarMass = zeros(1,12);
oilEnthalpy = zeros(1,12);
oilViscosity = zeros(1,12);
oilThermalConductivity = zeros(1,12);
oilSoundSpeed = zeros(1,12);
oilJouleThomsonCoefficient = zeros(1,12);

waterFractionc = zeros(1,12);
waterMolarVolume = zeros(1,12);
waterVolumeFraction = zeros(1,12);
waterWtFraction = zeros(1,12);
waterDensity = zeros(1,12);
waterZ = zeros(1,12);
waterKappa = zeros(1,12);
waterMolarMass = zeros(1,12);
waterEnthalpy = zeros(1,12);
waterViscosity = zeros(1,12);
waterThermalConductivity = zeros(1,12);
waterSoundSpeed = zeros(1,12);
waterJouleThomsonCoefficient = zeros(1,12);

for c = 1:size(P_bar,2)
    fluid.setTemperature(T_C(c)+273.15);
    fluid.setPressure(P_bar(c));
    TPflash(fluid,0);
    fluid.init(2);
    fluid.initPhysicalProperties();

    enthalpy_(c) = fluid.getEnthalpy();
    entropy(c) = fluid.getEntropy();
    numberOfPhases(c) = fluid.getNumberOfPhases();
    mixMolarVolume(c) = 1.0/fluid.getDensity("mol/m3");
    mixDensity(c) = fluid.getDensity("kg/m3");
    mixZfactor(c) = fluid.getZ();
    mixEnthalpy(c) = fluid.getEnthalpy("J/mol");
    mixEntropy(c) = fluid.getEntropy("J/molK");
    mixCp(c) = fluid.getCp("J/molK");
    mixCv(c) = fluid.getCv("J/molK");
    mixKappa(c) = fluid.getKappa();
    mixViscosity(c) = fluid.getViscosity("kg/msec");
    mixThermalConductivity(c) = fluid.getConductivity("W/mK");

    if (fluid.hasPhaseType("gas"))
        phaseNumber = fluid.getPhaseNumberOfPhase("gas");
        gasFractionc(c) = fluid.getMoleFraction(phaseNumber)*100;
        gasMolarVolume(c) = 1.0/fluid.getPhase(phaseNumber).getDensity("mol/m3");
        gasVolumeFraction(c) = fluid.getCorrectedVolumeFraction(phaseNumber)*100;
        gasDensity(c) = fluid.getPhase(phaseNumber).getDensity("kg/m3");
        gasZ(c) = fluid.getPhase(phaseNumber).getZ();
        gasMolarMass(c) = fluid.getPhase(phaseNumber).getMolarMass()*1000;
        gasEnthalpy(c) = fluid.getPhase(phaseNumber).getEnthalpy("J/mol");
        gasWtFraction(c) = fluid.getWtFraction(phaseNumber)*100;
        gasKappa(c) = fluid.getPhase(phaseNumber).getGamma();
        gasViscosity(c) = fluid.getPhase(phaseNumber).getViscosity("kg/msec");
        gasThermalConductivity(c) = fluid.getPhase(phaseNumber).getConductivity("W/mK");
        gasSoundSpeed(c) = fluid.getPhase(phaseNumber).getSoundSpeed();
        gasJouleThomsonCoefficient(c) = fluid.getPhase(phaseNumber).getJouleThomsonCoefficient()/1e5;
    end

    if (fluid.hasPhaseType("oil"))
        phaseNumber = fluid.getPhaseNumberOfPhase("oil");
        oilFractionc(c) = fluid.getMoleFraction(phaseNumber)*100;
        oilMolarVolume(c) = 1.0/fluid.getPhase(phaseNumber).getDensity("mol/m3");
        oilVolumeFraction(c) = fluid.getCorrectedVolumeFraction(phaseNumber)*100;
        oilDensity(c) = fluid.getPhase(phaseNumber).getDensity("kg/m3");
        oilZ(c) = fluid.getPhase(phaseNumber).getZ();
        oilMolarMass(c) = fluid.getPhase(phaseNumber).getMolarMass()*1000;
        oilEnthalpy(c) = fluid.getPhase(phaseNumber).getEnthalpy("J/mol");
        oilWtFraction(c) = fluid.getWtFraction(phaseNumber)*100;
        oilKappa(c) = fluid.getPhase(phaseNumber).getGamma();
        oilViscosity(c) = fluid.getPhase(phaseNumber).getViscosity("kg/msec");
        oilThermalConductivity(c) = fluid.getPhase(phaseNumber).getConductivity("W/mK");
        oilSoundSpeed(c) = fluid.getPhase(phaseNumber).getSoundSpeed();
        oilJouleThomsonCoefficient(c) = fluid.getPhase(phaseNumber).getJouleThomsonCoefficient()/1e5;
    end

    if (fluid.hasPhaseType("aqueous"))
        phaseNumber = fluid.getPhaseNumberOfPhase("aqueous");
        waterFractionc(c) = fluid.getMoleFraction(phaseNumber)*100;
        waterMolarVolume(c) = 1.0/fluid.getPhase(phaseNumber).getDensity("mol/m3");
        waterVolumeFraction(c) = fluid.getCorrectedVolumeFraction(phaseNumber)*100;
        waterDensity(c) = fluid.getPhase(phaseNumber).getDensity("kg/m3");
        waterZ(c) = fluid.getPhase(phaseNumber).getZ();
        waterMolarMass(c) = fluid.getPhase(phaseNumber).getMolarMass()*1000;
        waterEnthalpy(c) = fluid.getPhase(phaseNumber).getEnthalpy("J/mol");
        waterWtFraction(c) = fluid.getWtFraction(phaseNumber)*100;
        waterKappa(c) = fluid.getPhase(phaseNumber).getGamma();
        waterViscosity(c) = fluid.getPhase(phaseNumber).getViscosity("kg/msec");
        waterThermalConductivity(c) = fluid.getPhase(phaseNumber).getConductivity("W/mK");
        waterSoundSpeed(c) = fluid.getPhase(phaseNumber).getSoundSpeed();
        waterJouleThomsonCoefficient(c) = fluid.getPhase(phaseNumber).getJouleThomsonCoefficient()/1e5;
    end
end

errEnth = zeros(1,12);
for c = 1:size(P_bar,2)
    fluid.setPressure(P_bar(c));
    PHflash(fluid,enthalpy_(1,c),0);
    errEnth(c) = fluid.getTemperature() - 273.15 - T_C(c);
end

errEntr = zeros(1,12);
for c = 1:size(P_bar,2)
    fluid.setPressure(P_bar(c));
    PSflash(fluid,entropy(1,c),0);
    errEntr(c) = fluid.getTemperature() - 273.15 - T_C(c);
end

fluid.getPhase(0).displayInteractionCoefficients("")