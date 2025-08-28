# ⚡ MATLAB–COMSOL LiveLink SPAD Simulation

This repository contains automated simulation scripts for **1D nanowire PIN/SPAD device modeling** using **COMSOL Multiphysics** with **MATLAB LiveLink**.  
The workflow integrates geometry creation, physics setup, parameter configuration, study execution, voltage sweeps, and automated result extraction/plotting.

---

## 🔑 Features
- Modular MATLAB scripts for COMSOL model setup:
  - `init_model.m` → Initializes COMSOL model.  
  - `set_parameters.m` → Defines device geometry, doping, and ionization parameters.  
  - `build_geometry_physics.m` → Sets up geometry and semiconductor physics (PIN/SPAD structure).  
  - `run_studies.m` → Configures and executes stationary + transient studies.  
  - `run_voltage_sweep.m` → Automates voltage sweep (I–V and transient I–t analysis).  
  - `plot_all.m` → Generates plots of extracted results.  
- Fully automated workflow controlled by **`main.m`**.  
- Supports **bias-dependent I–V** and **transient I–t** curves.  
- Reproducible and extensible for SPAD research.

---

## 📊 Applications
- Single-Photon Avalanche Diode (**SPAD**) modeling.  
- Avalanche breakdown and transient analysis.  
- Voltage sweep automation for semiconductor devices.  
- PDE-based optoelectronic device simulations.  

---

## ⚙️ Requirements
- **COMSOL Multiphysics** (6.2) with **LiveLink for MATLAB**.  
- **MATLAB** R2025a.
- **COMSOL LiveLink™ for MATLAB**  

---

## ▶️ Usage
Clone the repository and run the workflow:  

```matlab
run('main.m')
