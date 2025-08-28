% ========================================================================
% run_studies.m
% ------------------------------------------------------------------------
% This script sets up and executes the studies for the SPAD simulation in 
% COMSOL using MATLAB LiveLink. 
%
% Workflow:
%   1. Run a stationary study to obtain the initial solution.
%   2. Enable impact ionization and configure a transient study for 
%      time-dependent avalanche simulations.
% ========================================================================

disp('=== Setting up Studies ===');

%% Step 1: Run Stationary Study
disp('--- Running Stationary Study ---');

% Disable impact ionization for initial stationary solve
model.component('comp1').physics('semi').feature('iig1').active(false);

% Create stationary study
model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/semi', true);

% Ensure mesh is up to date before solving
model.component('comp1').geom('geom1').run('fin');

% Run stationary study
model.study('std1').run;
disp('--- Stationary Study Completed ---');

%% Step 2: Set up Transient Study
disp('--- Enabling Impact Ionization and Setting Transient Study ---');

% Enable impact ionization for transient simulation
model.component('comp1').physics('semi').feature('iig1').active(true);

% Create transient study
model.study.create('std2');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').setSolveFor('/physics/semi', true);

% Set time units and time range (example: 0 ps to 1000 ps in steps of 10 ps)
model.study('std2').feature('time').set('tunit', 'ps');
model.study('std2').feature('time').set('tlist', 'range(0,10,1000)');

disp('=== Studies Setup Completed ===');