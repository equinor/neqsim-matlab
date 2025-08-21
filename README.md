![NeqSim Logo](https://github.com/equinor/neqsim/blob/master/docs/wiki/neqsimlogocircleflatsmall.png)

### NeqSim: A Powerful Java-Based Thermodynamic Toolbox for MATLAB

NeqSim, a robust and high-performance open-source library for thermodynamic and process simulation, offers seamless integration with MATLAB, making it an ideal toolbox for engineers and researchers. Its foundation in Java allows for direct utilization within the MATLAB environment, bypassing the need for complex wrappers or intermediary layers. This direct integration, coupled with NeqSim's comprehensive capabilities, provides a powerful platform for a wide range of process and thermodynamic calculations.

**Why NeqSim fits perfectly with MATLAB:**

*   **Java-native = MATLAB-native.** MATLAB possesses a built-in Java bridge, enabling the direct loading and use of NeqSim's Java classes. This eliminates the need for wrappers, MEX files, or a Python layer, streamlining the workflow and ensuring efficient communication between the two environments.

*   **Fast & robust.** NeqSim's performance is a key advantage. Running on the Java Virtual Machine (JVM) with Just-In-Time (JIT) optimization, it delivers high-speed calculations. A benchmark demonstrated NeqSim's capability to perform 5,000 multiphase flash calculations in just 2.8 seconds. The maturity of its numerical solvers contributes to stable and reliable phase behavior and property calculations, essential for complex process simulations such as CO2 removal, oil and gas transport, and flow assurance.

*   **A full process & thermodynamics toolbox.** All of NeqSim's extensive Java Application Programming Interfaces (APIs) are directly accessible from MATLAB. This provides users with a complete suite of tools, including thermodynamic systems, unit operations, property models, and flash calculations, making NeqSim a practical, production-grade toolbox for a variety of applications.

*   **Use the GitHub Java code as-is.** The entire NeqSim Java codebase is available on GitHub and can be directly utilized. By building the repository into a JAR file using tools like Maven or Gradle, users can add it to MATLAB's classpath. This also allows for the inclusion of custom Java classes, which can be immediately called from within MATLAB, offering a high degree of flexibility and customization.

In essence, NeqSim's Java architecture, combined with MATLAB's inherent capabilities, creates a powerful and user-friendly environment for advanced process and thermodynamic modeling and simulation.

# NeqSim Matlab
NeqSim Matlab is part of the [NeqSim project](https://equinor.github.io/neqsimhome/). NeqSim Matlab is a Matlab interface to the [NeqSim Java library](https://github.com/equinor/neqsim) for estimation of fluid behavior and process design.

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
