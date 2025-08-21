![NeqSim Logo](https://github.com/equinor/neqsim/blob/master/docs/wiki/neqsimlogocircleflatsmall.png)

# NeqSim Matlab
NeqSim Matlab is part of the [NeqSim project](https://equinor.github.io/neqsimhome/). NeqSim Matlab is a Matlab interface to the [NeqSim Java library](https://github.com/equinor/neqsim) for estimation of fluid behavior and process design.

## NeqSim: A Powerful Java-Based Thermodynamic Toolbox for MATLAB

NeqSim, a robust and high-performance open-source library for thermodynamic and process simulation, offers seamless integration with MATLAB, making it an ideal toolbox for engineers and researchers. Its foundation in Java allows for direct utilization within the MATLAB environment, bypassing the need for complex wrappers or intermediary layers. This direct integration, coupled with NeqSim's comprehensive capabilities, provides a powerful platform for a wide range of process and thermodynamic calculations.

**Why NeqSim fits perfectly with MATLAB:**

*   **Java-native = MATLAB-native.** MATLAB possesses a built-in Java bridge, enabling the direct loading and use of NeqSim's Java classes. This eliminates the need for wrappers, MEX files, or a Python layer, streamlining the workflow and ensuring efficient communication between the two environments.

*   **Fast & robust.** NeqSim's performance is a key advantage. Running on the Java Virtual Machine (JVM) with Just-In-Time (JIT) optimization, it delivers high-speed calculations. The maturity of its numerical solvers contributes to stable and reliable phase behavior and property calculations, essential for complex process simulations such as CO2 removal, oil and gas transport, and flow assurance.

*   **A full process & thermodynamics toolbox.** All of NeqSim's extensive Java Application Programming Interfaces (APIs) are directly accessible from MATLAB. This provides users with a complete suite of tools, including thermodynamic systems, unit operations, property models, and flash calculations, making NeqSim a practical, production-grade toolbox for a variety of applications.

*   **Use the GitHub Java code as-is.** The entire NeqSim Java codebase is available on GitHub and can be directly utilized. By building the repository into a JAR file using tools like Maven or Gradle, users can add it to MATLAB's classpath. This also allows for the inclusion of custom Java classes, which can be immediately called from within MATLAB, offering a high degree of flexibility and customization.

## Releases
See [release folder](https://github.com/equinor/neqsimmatlab/releases)

## Getting Started
See the [NeqSim Matlab Wiki](https://github.com/equinor/neqsimmatlab/wiki) for how to use NeqSim Matlab.


### Initial setup
The NeqSim Matlab package is downloaded by cloning the library to your local computer (alternatively fork it to your private reprository). The following commands are dependent on a local installation of [GIT](https://git-scm.com/). 

```bash
git clone https://github.com/equinor/neqsimmatlab.git
cd neqsimmatlab
```

Of course. Here is the provided text formatted as a Markdown document, ready to be pasted into a GitHub `README.md` file.

---

## MATLAB Quick-Start

### 1) Build / Obtain the JARs

From https://github.com/equinor/neqsim build from source using Maven. This will generate the necessary JAR file in the `target/` directory, along with any dependencies.

```sh
mvn -DskipTests package
```
Alternatively, use your existing prebuilt NeqSim JARs. Place them all in a single folder, for example, `C:\neqsim\lib\`.

### 2) Add JARs to MATLAB’s Classpath

You can add the JARs to MATLAB's Java classpath at runtime.

```matlab
% Point to your folder with NeqSim + dependency JARs
jarDir = 'C:\neqsim\lib';  % <- change to your path
jars = dir(fullfile(jarDir, '*.jar'));
for k = 1:numel(jars)
    javaaddpath(fullfile(jarDir, jars(k).name));
end
```

**Tip:** To make this change permanent, you can add the same `javaaddpath` lines to your `startup.m` file or edit `javaclasspath.txt` directly.

### 3) Call NeqSim from MATLAB (Example: TP flash)

Once the JARs are on the classpath, you can import and use NeqSim classes directly.

```matlab
import neqsim.thermo.system.*
import neqsim.thermodynamicOperations.*

% Create a thermodynamic system (SRK, 298.15 K, 50 bar)
sys = SystemSrkEos(298.15, 50.0);
sys.addComponent('methane', 0.9);
sys.addComponent('ethane', 0.1);
sys.setMixingRule('classic');
sys.init(0);

% Run TP flash
ops = ThermodynamicOperations(sys);
ops.TPflash();

% Read results
P_bar    = sys.getPressure();                     % bar
T_K      = sys.getTemperature();                  % K
z_gas    = sys.getPhase(0).getZ();                % Compressibility factor
rho_gas  = sys.getPhase(0).getDensity('kg/m3');   % Density
x_gas    = char(sys.getPhase(0).getComponent(0).getName()); %#ok<NASGU>
beta_vap = sys.getBeta(0);                        % Vapor fraction

fprintf('P = %.2f bar, T = %.2f K, Z_gas = %.4f, rho_gas = %.3f kg/m3, beta_vap = %.3f\n', ...
        P_bar, T_K, z_gas, rho_gas, beta_vap);
```

### 4) Use as a Toolbox for Process/Thermo Tasks

NeqSim's integration enables a powerful workflow:

*   **Build flowsheets** by instantiating NeqSim unit operations in Java and controlling them from MATLAB scripts.
*   **Loop over operating points** to perform sensitivity scans, optimization, or Monte Carlo simulations. Let MATLAB manage the arrays and loops while NeqSim handles the complex physics.
*   **Extend with your own Java classes** (e.g., new unit operations or property models). Simply rebuild, drop the new JAR into the same folder, and MATLAB will recognize it instantly.

### Practical Notes

*   **JVM Compatibility**: Ensure MATLAB’s bundled JVM version is compatible with the Java version you used to build NeqSim (e.g., Java 8/11+). If there is a mismatch, you may need to rebuild NeqSim for your specific MATLAB JVM.
*   **Dependencies**: Remember to add all required JARs (NeqSim + its dependencies) to the classpath for the library to function correctly.
*   **Performance**: For optimal speed, keep long-running sessions active to allow the Java JIT (Just-In-Time) compiler to warm up. Vectorize your scans and loops in MATLAB while delegating the heavy thermodynamic calculations to NeqSim.

In short, because NeqSim is Java-based, everything in the GitHub Java codebase can be compiled and used directly inside MATLAB, giving you a fast, robust, and full-featured process/thermo toolbox without needing any glue code.

## Contributing
Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.

## Discussion forum
Questions related to neqsim can be posted in the [github discussion pages](https://github.com/equinor/neqsim/discussions).

## Versioning
NeqSim use [SemVer](https://semver.org/) for versioning.

## Licence
NeqSim is distributed under the [Apache-2.0](https://github.com/equinor/neqsimsource/blob/master/LICENSE) licence.

## Acknowledgments
A number of master and PhD students at NTNU have contributed to development of NeqSim. We greatly acknowledge their contributions.


File System
doc/ : Documentation for this library.
example/ : Contains several examples of how EJML can be used to solve different problems or how neqsim can be modified for different applications.
neqsim/ : Library source code
lib/ : various labraries used for implementing NeqSim in Matlab
ext/: external libraries used by NeqSim Matlab
changelog.txt : History of what changed between each version.
license.txt: license document
