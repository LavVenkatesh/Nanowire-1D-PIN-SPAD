% ==========================================
% init_model.m
% ==========================================

disp('=== Initializing COMSOL Model ===');

% --- Import COMSOL LiveLink ---
import com.comsol.model.*
import com.comsol.model.util.*

% --- Create a new COMSOL model object ---
model = ModelUtil.create('Model_main_27');

disp('--- Model object created ---');

% --- Load predefined parameters (geometry, physics, bias voltages, etc.) ---
run('set_parameters.m');