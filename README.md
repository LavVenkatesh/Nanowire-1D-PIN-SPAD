# ⚡ MATLAB–COMSOL LiveLink SPAD Simulation

This repository contains automated simulation scripts for **1D nanowire PIN SPAD device modeling** using **COMSOL Multiphysics** with **MATLAB LiveLink**.  
The workflow integrates geometry creation, physics setup, parameter configuration, study execution, voltage sweeps, and automated result extraction/plotting.

## 📖 References

This project is based on methodologies and concepts discussed in the following reference:

-[Li, Z., Tan, H. H., Jagadish, C., & Fu, L., 2024](https://iopscience.iop.org/article/10.1088/1361-6528/ad2019)

---

## 📂 Repository Structure


- `init_model.m` → Initializes COMSOL model.  
- `set_parameters.m` → Defines device geometry, doping, and ionization parameters.  
- `build_geometry_physics.m` → Sets up geometry and semiconductor physics (PIN SPAD structure).  
- `run_studies.m` → Configures and executes stationary + transient studies.  
- `run_voltage_sweep.m` → Automates voltage sweep (I–V and transient I–t analysis).  
- `plot_all.m` → Generates plots of extracted results.  

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
