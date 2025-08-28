% ==========================================
% main.m
% MATLAB–COMSOL LiveLink 1D PIN SPAD Simulation
% ==========================================
% This script runs the complete simulation flow:
%   1. Initialize COMSOL model
%   2. Build geometry & assign physics
%   3. Run studies (time-dependent / stationary)
%   4. Perform voltage sweep (I–V and I–t curves)
%   5. Plot all results
%
% Author: Lavanya Venkatesh
% Date: August 2025
% Repository: https://github.com/LavVenkatesh/Nanowire-1D-PIN-SPAD.git
% ==========================================

clc; clear; close all;

disp('=== Starting SPAD Simulation Workflow ===');

% --- Step 1: Initialize Model ---
run('init_model.m');

% --- Step 2: Build Geometry & Physics ---
run('build_geometry_physics.m');

% --- Step 3: Run Studies ---
run('run_studies.m');

% --- Step 4: Voltage Sweep ---
run('run_voltage_sweep.m');

% --- Step 5: Plot Results ---
run('plot_all.m');

disp('=== Simulation Completed Successfully ===');