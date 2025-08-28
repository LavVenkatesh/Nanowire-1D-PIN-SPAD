% ==========================================
% build_geometry_physics.m
% Build geometry, assign physics, and set material properties
% for the SPAD COMSOL model.
% ==========================================
% This script:
%   1. Creates the 1D geometry (PIN structure)
%   2. Adds semiconductor physics with impact ionization
%   3. Defines contacts and doping regions
%   4. Assigns material properties (InP semiconductor)
%   5. Generates mesh
% ==========================================

disp('=== Building Geometry and Physics ===');

%% --- Geometry Setup (1D nanowire structure) ---
model.component.create('comp1', true);
model.component('comp1').geom.create('geom1', 1);
model.component('comp1').geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);

% Define interval for device length
model.component('comp1').geom('geom1').create('i1', 'Interval');
model.component('comp1').geom('geom1').feature('i1').setIndex('coord', 'L', 1);
model.component('comp1').geom('geom1').run('i1');

% Add points for region boundaries
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').setIndex('p', 'Lp', 0);
model.component('comp1').geom('geom1').run('pt1');

model.component('comp1').geom('geom1').create('pt2', 'Point');
model.component('comp1').geom('geom1').feature('pt2').setIndex('p', 'Lp+Li', 0);
model.component('comp1').geom('geom1').run;

%% --- Semiconductor Physics Setup ---
model.component('comp1').physics.create('semi', 'Semiconductor', 'geom1');

% Set cross-sectional area and statistics
model.component('comp1').physics('semi').prop('d').set('A', 'A');
model.component('comp1').physics('semi').prop('ModelProperties').set('CarrierStatistics', 'FermiDirac');

% Base semiconductor model
model.component('comp1').physics('semi').feature('smm1').set('minput_temperature', 'CT');
model.component('comp1').physics('semi').feature('smm1').create('mmct1', 'CaugheyThomasMobilityModel', 1);

% Trap-assisted recombination
model.component('comp1').physics('semi').create('tar1', 'TrapAssistedRecombination', 1);
model.component('comp1').physics('semi').feature('tar1').selection.all;

% Impact ionization (user-defined model)
model.component('comp1').physics('semi').create('iig1', 'IIGeneration', 1);
model.component('comp1').physics('semi').feature('iig1').selection.all;
model.component('comp1').physics('semi').feature('iig1').set('iiG_model', 'UserDefined');
model.component('comp1').physics('semi').feature('iig1').set('alpha_n', 'A_n * exp(-(B_n / semi.normE)^C_n)');
model.component('comp1').physics('semi').feature('iig1').set('alpha_p', 'A_p * exp(-(B_p / semi.normE)^C_p)');

% Contacts
model.component('comp1').physics('semi').create('mc1', 'MetalContact', 0);
model.component('comp1').physics('semi').feature('mc1').selection.set(1);

model.component('comp1').physics('semi').create('mc2', 'MetalContact', 0);
model.component('comp1').physics('semi').feature('mc2').selection.set(4);
model.component('comp1').physics('semi').feature('mc2').set('V0', 'V_bias');

% Doping models
model.component('comp1').physics('semi').create('adm1', 'AnalyticDopingModel', 1);
model.component('comp1').physics('semi').feature('adm1').selection.set(1);
model.component('comp1').physics('semi').feature('adm1').set('NAc', 'Np');

model.component('comp1').physics('semi').create('adm2', 'AnalyticDopingModel', 1);
model.component('comp1').physics('semi').feature('adm2').selection.set(2);
model.component('comp1').physics('semi').feature('adm2').set('impurityType', 'donor');
model.component('comp1').physics('semi').feature('adm2').set('NDc', 'Ni');

model.component('comp1').physics('semi').create('adm3', 'AnalyticDopingModel', 1);
model.component('comp1').physics('semi').feature('adm3').selection.set(3);
model.component('comp1').physics('semi').feature('adm3').set('impurityType', 'donor');
model.component('comp1').physics('semi').feature('adm3').set('NDc', 'Nn');

%% --- Material Definition (InP) ---
model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material('mat1').label('InP - Indium Phosphide');

% Default properties
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', ...
    {'12.5' '0' '0' '0' '12.5' '0' '0' '0' '12.5'});
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', ...
    {'68[W/(m*K)]' '0' '0' '0' '68[W/(m*K)]' '0' '0' '0' '68[W/(m*K)]'});
model.component('comp1').material('mat1').propertyGroup('def').set('density', '4810[kg/m^3]');
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', '310[J/(kg*K)]');

% Semiconductor parameters
model.component('comp1').material('mat1').propertyGroup.create('SemicondMaterial', 'Semiconductor material');
model.component('comp1').material('mat1').propertyGroup('SemicondMaterial').set('Eg0', '1.344[V]');
model.component('comp1').material('mat1').propertyGroup('SemicondMaterial').set('chi0', '4.38[V]');
model.component('comp1').material('mat1').propertyGroup('SemicondMaterial').set('Nv', '(T/1[K])^(3/2)*2.2e15[1/cm^3]');
model.component('comp1').material('mat1').propertyGroup('SemicondMaterial').set('Nc', '(T/1[K])^(3/2)*1.1e14[1/cm^3]');
model.component('comp1').material('mat1').propertyGroup('SemicondMaterial').set('mun', {'mu_n'});
model.component('comp1').material('mat1').propertyGroup('SemicondMaterial').set('mup', {'mu_p'});
model.component('comp1').material('mat1').propertyGroup('SemicondMaterial').addInput('temperature');

% Advanced models (Jain-Roulston, Caughey-Thomas, SRH recombination)
model.component('comp1').material('mat1').propertyGroup.create('JainRoulstonModel', 'Jain–Roulston model');
model.component('comp1').material('mat1').propertyGroup.create('CaugheyThomasMobilityModel', 'Caughey-Thomas mobility model');
model.component('comp1').material('mat1').propertyGroup.create('SRH', 'Shockley-Read-Hall recombination');

% Set model-specific properties
model.component('comp1').material('mat1').propertyGroup('SRH').set('taun', {'tau_n'});
model.component('comp1').material('mat1').propertyGroup('SRH').set('taup', {'tau_p'});

%% --- Mesh Generation ---
model.component('comp1').mesh.create('mesh1');
model.component('comp1').mesh('mesh1').autoMeshSize(3);

% Finalize geometry
model.component('comp1').geom('geom1').run('fin');

disp('=== Geometry and Physics Built ===');
