% ==========================================
% set_parameters.m
% ==========================================
% This script:
%   1. Imports COMSOL LiveLink API classes
%   2. Creates a new COMSOL model object
%   3. Loads simulation parameters from set_parameters.m
% ==========================================

disp('--- Setting Parameters ---');

%% --- Geometry and device parameters ---
model.param.set('V_bias', '0[V]', 'Applied Voltage');
model.param.set('L', '3', 'Total device length [m]');
model.param.set('Lp', '1', 'p-region length [m]');
model.param.set('Li', '0.95', 'i-region length [m]');
model.param.set('Ln', 'L - Lp - Li', 'n-region length [m]');
model.param.set('D', '200e-9[m]', 'Nanowire diameter [m]');
model.param.set('A', 'pi*(D/2)^2', ...
    ['Cross-sectional area [m' native2unicode(hex2dec({'00' 'b2'}), 'unicode') ']']);

%% --- Doping concentrations ---
model.param.set('Np', '1e18 [1/cm^3]', 'p-region doping');
model.param.set('Ni', '5e15 [1/cm^3]', 'i-region background doping');
model.param.set('Nn', '1e18 [1/cm^3]', 'n-region doping');

%% --- Ionization model parameters (Okuto–Crowell model) ---
model.param.set('A_n', '403e8[1/m]', 'Electron ionization prefactor');
model.param.set('B_n', '77.3e8[V/m]', 'Electron ionization field parameter');
model.param.set('C_n', '0.44', 'Electron ionization coefficient');
model.param.set('A_p', '1.68e8[1/m]', 'Hole ionization prefactor');
model.param.set('B_p', '1.15e8[V/m]', 'Hole ionization field parameter');
model.param.set('C_p', '1.39', 'Hole ionization coefficient');
model.param.set('CT', '150[K]', 'Critical temperature for impact ionization');

%% --- Secondary transport parameters ---
model.param.create('par2');
model.param('par2').set('tau_n', '1[ns]', 'Electron lifetime');
model.param('par2').set('tau_p', '1[ns]', 'Hole lifetime');
model.param('par2').set('mu_n', '120 [cm^2/V/s]', 'Electron mobility');
model.param('par2').set('mu_p', '100 [cm^2/V/s]', 'Hole mobility');

disp('--- Parameters Set Successfully ---');