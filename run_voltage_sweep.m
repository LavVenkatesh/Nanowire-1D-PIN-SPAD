% ========================================================================
% run_voltage_sweep.m
% ------------------------------------------------------------------------
% Performs voltage sweep for SPAD simulation in two stages:
%   1. Coarse sweep (0–40 V, step = 1 V) to identify breakdown region
% ========================================================================

%% === Step 1: Coarse Voltage Sweep ===
disp('=== Step 1: Coarse Voltage Sweep ===');

voltages_coarse = 0:1:40;
nCoarse = length(voltages_coarse);
N_std = 6;  % threshold for breakdown detection

I_all_series = cell(1, nCoarse);
I_final_values = [];
I_mean = [];
I_std = [];

prevSol = 'sol1';

for i = 1:nCoarse
    V = voltages_coarse(i);

    solName = ['sol_coarse' num2str(i)];
    dsetName = ['dset' num2str(i+1)];

    disp(['--- Running for V = ' num2str(V) ' V ---']);

    % Set applied bias
    model.param.set('V_bias', [num2str(V) '[V]']);

    % Define solution sequence
    model.sol.create(solName);
    model.sol(solName).study('std2');
    model.sol(solName).create('st1', 'StudyStep');
    model.sol(solName).feature('st1').set('study', 'std2');
    model.sol(solName).feature('st1').set('studystep', 'time');

    model.sol(solName).create('v1', 'Variables');
    model.sol(solName).feature('v1').set('control', 'user');
    model.sol(solName).feature('v1').set('initmethod', 'sol');
    model.sol(solName).feature('v1').set('initsol', prevSol);

    model.sol(solName).create('t1', 'Time');
    model.sol(solName).feature('t1').set('tlist', 'range(0,10,1000)');

    try
        % Run simulation
        model.sol(solName).runAll;

        % Extract time and current
        t_series = mphglobal(model, 't', 'dataset', dsetName);
        I_series = mphglobal(model, 'semi.I0_2', 'dataset', dsetName);

        % Store results
        I_all_series{i} = struct('V', V, 't', t_series, 'I', I_series, 'Ifinal', I_series(end));
        I_final_values(end+1) = abs(I_series(end));
        I_mean(end+1) = abs(mean(I_final_values, 'omitnan'));
        I_std(end+1) = std(I_final_values, 'omitnan');

        prevSol = solName;

    catch ME
        disp(['✗ Error at V = ' num2str(V) ': ' ME.message]);
    end
end

% Package results
coarse_data = struct( ...
    'voltages', voltages_coarse, ...
    'I_time_series', I_all_series, ...
    'I_final', I_final_values, ...
    'I_mean', I_mean, ...
    'I_std', I_std ...
);
assignin('base', 'coarse_data', coarse_data);

valid_len = length(I_final_values);
coarse_summary = table( ...
    voltages_coarse(1:valid_len).', ...
    I_final_values(:), ...
    I_mean(:), ...
    I_std(:), ...
    'VariableNames', {'Voltage_V', 'I_final_A', 'I_mean_A', 'I_std_A'} ...
);
assignin('base', 'coarse_summary', coarse_summary);