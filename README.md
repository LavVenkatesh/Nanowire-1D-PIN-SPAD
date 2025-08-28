📂 MATLAB–COMSOL LiveLink SPAD Simulation

This repository contains automated simulation scripts for 1D nanowire PIN/SPAD device modeling using COMSOL Multiphysics with MATLAB LiveLink. The workflow integrates geometry creation, physics setup, parameter configuration, study execution, voltage sweeps, and automated result extraction/plotting.

🔑 Features

Modular MATLAB scripts for COMSOL model setup:

init_model.m → initializes COMSOL model.

set_parameters.m → defines device geometry, doping, and ionization parameters.

build_geometry_physics.m → sets up geometry and semiconductor physics (PIN/SPAD structure).

run_studies.m → configures and executes stationary + transient studies.

run_voltage_sweep.m → performs voltage sweep (I–V and transient I–t analysis).

plot_all.m → generates plots of extracted results.

Fully automated simulation workflow controlled by main.m.

Supports bias-dependent I–V and transient current (I–t) curves.

Reproducible and extensible for SPAD research.

📊 Applications

Single-Photon Avalanche Diode (SPAD) modeling.

Avalanche breakdown and transient analysis.

Voltage sweep automation for semiconductor devices.

PDE-based optoelectronic device simulations.

⚙️ Requirements

COMSOL Multiphysics (≥ 6.x) with LiveLink for MATLAB.

MATLAB R202x.

▶️ Usage

Clone the repo.

Open MATLAB with COMSOL LiveLink enabled.

Run the workflow using:

run('main.m')


Results (I–V, I–t, field distributions, etc.) will be saved and plotted automatically.
