% ========================================================================
% plot_all.m
% ------------------------------------------------------------------------
% Generates plots (IV curves and I–t dynamics)
% ========================================================================

disp('=== Step 3: Plotting Results ===');

% --- Coarse IV Curve ---
figure;
plot(coarse_summary.Voltage_V, coarse_summary.I_final_A, 'o-b', 'LineWidth', 1.5);
xlabel('Voltage (V)'); ylabel('Current (A)');
title('IV Curve (Coarse Sweep)');
set(gca,'YScale','log'); grid on;

% --- Coarse I–t Curves with colormap ---
figure; hold on; grid on;

nV = length(coarse_data.I_time_series);
colors = jet(nV);   % colormap for voltages

for idx = 1:nV
    if ~isempty(coarse_data.I_time_series{idx})
        t_ps = coarse_data.I_time_series{idx}.t * 1e12;   
        I = coarse_data.I_time_series{idx}.I;
        V = coarse_data.I_time_series{idx}.V;

        plot(t_ps, I, 'Color', colors(idx,:), 'LineWidth', 1.2);
    end
end

xlabel('Time (ps)');
ylabel('Current (A)');
title('I–t Curves');

% Create colorbar for voltages
colormap(jet(nV));
c = colorbar;
c.Label.String = 'Voltage (V)';
c.Ticks = linspace(0,1,6);  % 6 ticks (adjust as needed)
c.TickLabels = round(linspace(1,40,6));  % match coarse sweep range

set(gca,'YScale','log'); 
hold off;
disp('=== Plotting Complete ===');