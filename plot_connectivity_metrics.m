% Definizione dei task
tasks = categorical({'Rest', 'ME', 'MI'}); % Crea categorie per asse X
tasks = reordercats(tasks, {'Rest', 'ME', 'MI'}); % Ordina le categorie

%% banda alpha (soglia 0.4)
% coherence
% Valori di coerenza per ogni gruppo di elettrodi nei tre task
coh_all_left = [0.315, 0.318, 0.310];   
coh_all_right = [0.315, 0.334, 0.327];  
coh_sens_left = [0.3, 0.321, 0.307]; 
coh_sens_right = [0.3, 0.324, 0.321];  
coh_sens_left_left = [0.371, 0.362, 0.344]; % left hemisphere, left hand
coh_sens_left_right = [0.371,0.378, 0.388]; % left hemisphere, right hand
coh_sens_right_left = [0.329, 0.333, 0.330];  % right hemisphere, left hand
coh_sens_right_right = [0.329, 0.341, 0.343];  % right hemisphere, right hand
coh_fp_left = [0.404, 0.398, 0.404];    
coh_fp_right = [0.404, 0.404, 0.404];   
% density
dens_all_left = [0.276, 0.264, 0.245];   
dens_all_right = [0.276, 0.308, 0.277];  
dens_sens_left = [0.167, 0.186, 0.167]; 
dens_sens_right = [0.167, 0.167, 0.188];  
dens_sens_left_left = [0.225, 0.226, 0.203]; % left hemisphere, left hand
dens_sens_left_right = [0.225, 0.225, 0.238]; % left hemisphere, right hand
dens_sens_right_left = [0.183, 0.183, 0.191];  % right hemisphere, left hand
dens_sens_right_right = [0.183, 0.207, 0.204];  % right hemisphere, right hand
dens_fp_left = [0.299, 0.285, 0.291];    
dens_fp_right = [0.299, 0.311, 0.293];  

% Creazione del grafico
figure; 

% coherence left hand
subplot(2, 2, 1);
hold on;
plot(tasks, coh_sens_left_left, '-o', 'Color', 'green', 'LineWidth', 2, 'MarkerSize', 8); % ipsilateral
plot(tasks, coh_sens_right_left, '-o', 'Color', 'red', 'LineWidth', 2, 'MarkerSize', 8); % controlateral
plot(tasks, coh_fp_left, '-ob', 'LineWidth', 2, 'MarkerSize', 8);   
plot(tasks, coh_all_left, '-ok', 'LineWidth', 2, 'MarkerSize', 8);  

% Aggiungere i valori vicino ai punti
for i = 1:length(tasks)
    text(tasks(i), coh_sens_left_left(i), sprintf('%.3f', coh_sens_left_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'green');
    text(tasks(i), coh_sens_right_left(i), sprintf('%.3f', coh_sens_right_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'red');
    text(tasks(i), coh_fp_left(i), sprintf('%.3f', coh_fp_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
    text(tasks(i), coh_all_left(i), sprintf('%.3f', coh_all_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'k');
end

hold off;
ylim([0.25 0.45]);
ylabel('Mean coherence');
title('Left Hand');
grid on;

% coherence right hand
subplot(2, 2, 2);
hold on;
plot(tasks, coh_sens_right_right, '-o', 'Color', 'green', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, coh_sens_left_right, '-o', 'Color', 'red', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, coh_fp_right, '-ob', 'LineWidth', 2, 'MarkerSize', 8);   
plot(tasks, coh_all_right, '-ok', 'LineWidth', 2, 'MarkerSize', 8); 

% Aggiungere i valori vicino ai punti
for i = 1:length(tasks)
    text(tasks(i), coh_sens_right_right(i), sprintf('%.3f', coh_sens_right_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'green');
    text(tasks(i), coh_sens_left_right(i), sprintf('%.3f', coh_sens_left_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'red');
    text(tasks(i), coh_fp_right(i), sprintf('%.3f', coh_fp_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
    text(tasks(i), coh_all_right(i), sprintf('%.3f', coh_all_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'k');
end

hold off;
ylim([0.25 0.45]);
ylabel('Mean coherence');
title('Right Hand');
grid on;

% density left hand
subplot(2, 2, 3);
hold on;
plot(tasks, dens_sens_left_left, '-o', 'Color', 'green', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, dens_sens_right_left, '-o', 'Color', 'red', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, dens_fp_left, '-ob', 'LineWidth', 2, 'MarkerSize', 8);   
plot(tasks, dens_all_left, '-ok', 'LineWidth', 2, 'MarkerSize', 8);  

% Aggiungere i valori vicino ai punti
for i = 1:length(tasks)
    text(tasks(i), dens_sens_left_left(i), sprintf('%.3f', dens_sens_left_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'green');
    text(tasks(i), dens_sens_right_left(i), sprintf('%.3f', dens_sens_right_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'red');
    text(tasks(i), dens_fp_left(i), sprintf('%.3f', dens_fp_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
    text(tasks(i), dens_all_left(i), sprintf('%.3f', dens_all_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'k');
end

hold off;
ylim([0.15 0.35]);
xlabel('Task');
ylabel('Network density');
grid on;

% density right hand
subplot(2, 2, 4);
hold on; 
plot(tasks, dens_sens_right_right, '-o', 'Color', 'green', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, dens_sens_left_right, '-o', 'Color', 'red', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, dens_fp_right, '-ob', 'LineWidth', 2, 'MarkerSize', 8);   
plot(tasks, dens_all_right, '-ok', 'LineWidth', 2, 'MarkerSize', 8); 

% Aggiungere i valori vicino ai punti
for i = 1:length(tasks)
    text(tasks(i), dens_sens_right_right(i), sprintf('%.3f', dens_sens_right_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'green');
    text(tasks(i), dens_sens_left_right(i), sprintf('%.3f', dens_sens_left_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'red');
    text(tasks(i), dens_fp_right(i), sprintf('%.3f', dens_fp_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
    text(tasks(i), dens_all_right(i), sprintf('%.3f', dens_all_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'k');
end

hold off;
ylim([0.15 0.35]);
xlabel('Task');
ylabel('Network density');
grid on;

% Creazione di una legenda globale
hL = legend({'Sensori-motor (ipsilateral)', 'Sensori-motor (controlateral)', 'Fronto-Parietal', 'All electrodes'}, ...
            'Position', [0.5, 0.05, 0.01, 0.01], 'Units', 'normalized');
% Sposta la legenda fuori dai subplot
set(hL, 'Orientation', 'vertical'); % Legenda orizzontale

% Titolo generale per tutta la figura
sgtitle('EEG coherence in the alpha band'); 

%% banda beta (soglia 0.4)
% coherence
% Valori di coerenza per ogni gruppo di elettrodi nei tre task
coh_all_left = [0.307, 0.302, 0.301];   
coh_all_right = [0.307, 0.315, 0.298];  
coh_sens_left = [0.311, 0.315, 0.307]; 
coh_sens_right = [0.311, 0.315, 0.312]; 
coh_sens_left_left = [0.367, 0.356, 0.358]; % left hemisphere, left hand
coh_sens_left_right = [0.367, 0.368, 0.369]; % left hemisphere, right hand
coh_sens_right_left = [0.351, 0.335, 0.338];  % right hemisphere, left hand
coh_sens_right_right = [0.351, 0.340, 0.338]; % right hemisphere, right hand
coh_fp_left = [0.403, 0.385, 0.399];    
coh_fp_right = [0.403, 0.392, 0.397]; 

% density
dens_all_left = [0.242, 0.224, 0.225];   
dens_all_right = [0.242, 0.242, 0.217];  
dens_sens_left = [0.189, 0.187, 0.188]; 
dens_sens_right = [0.189, 0.188, 0.190];  
dens_sens_left_left = [0.225, 0.227, 0.221]; % left hemisphere, left hand
dens_sens_left_right = [0.225, 0.219, 0.223]; % left hemisphere, right hand
dens_sens_right_left = [0.209, 0.187, 0.179];  % right hemisphere, left hand
dens_sens_right_right = [0.209, 0.178, 0.188];  % right hemisphere, right hand
dens_fp_left = [0.293, 0.273, 0.269];    
dens_fp_right = [0.293, 0.262, 0.268];  

% Creazione del grafico
figure; 

% coherence left hand
subplot(2, 2, 1);
hold on;
plot(tasks, coh_sens_left_left, '-o', 'Color', 'green', 'LineWidth', 2, 'MarkerSize', 8); % ipsilateral
plot(tasks, coh_sens_right_left, '-o', 'Color', 'red', 'LineWidth', 2, 'MarkerSize', 8); % controlateral
plot(tasks, coh_fp_left, '-ob', 'LineWidth', 2, 'MarkerSize', 8);   
plot(tasks, coh_all_left, '-ok', 'LineWidth', 2, 'MarkerSize', 8);  

% Aggiungere i valori vicino ai punti
for i = 1:length(tasks)
    text(tasks(i), coh_sens_left_left(i), sprintf('%.3f', coh_sens_left_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'green');
    text(tasks(i), coh_sens_right_left(i), sprintf('%.3f', coh_sens_right_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'red');
    text(tasks(i), coh_fp_left(i), sprintf('%.3f', coh_fp_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
    text(tasks(i), coh_all_left(i), sprintf('%.3f', coh_all_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'k');
end

hold off;
ylim([0.25 0.45]);
ylabel('Mean coherence');
title('Left Hand');
grid on;

% coherence right hand
subplot(2, 2, 2);
hold on;
plot(tasks, coh_sens_right_right, '-o', 'Color', 'green', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, coh_sens_left_right, '-o', 'Color', 'red', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, coh_fp_right, '-ob', 'LineWidth', 2, 'MarkerSize', 8);   
plot(tasks, coh_all_right, '-ok', 'LineWidth', 2, 'MarkerSize', 8); 

% Aggiungere i valori vicino ai punti
for i = 1:length(tasks)
    text(tasks(i), coh_sens_right_right(i), sprintf('%.3f', coh_sens_right_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'green');
    text(tasks(i), coh_sens_left_right(i), sprintf('%.3f', coh_sens_left_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'red');
    text(tasks(i), coh_fp_right(i), sprintf('%.3f', coh_fp_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
    text(tasks(i), coh_all_right(i), sprintf('%.3f', coh_all_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'k');
end

hold off;
ylim([0.25 0.45]);
ylabel('Mean coherence');
title('Right Hand');
grid on;

% density left hand
subplot(2, 2, 3);
hold on;
plot(tasks, dens_sens_left_left, '-o', 'Color', 'green', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, dens_sens_right_left, '-o', 'Color', 'red', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, dens_fp_left, '-ob', 'LineWidth', 2, 'MarkerSize', 8);   
plot(tasks, dens_all_left, '-ok', 'LineWidth', 2, 'MarkerSize', 8);  

% Aggiungere i valori vicino ai punti
for i = 1:length(tasks)
    text(tasks(i), dens_sens_left_left(i), sprintf('%.3f', dens_sens_left_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'green');
    text(tasks(i), dens_sens_right_left(i), sprintf('%.3f', dens_sens_right_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'red');
    text(tasks(i), dens_fp_left(i), sprintf('%.3f', dens_fp_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
    text(tasks(i), dens_all_left(i), sprintf('%.3f', dens_all_left(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'k');
end

hold off;
ylim([0.15 0.35]);
xlabel('Task');
ylabel('Network density');
grid on;

% density right hand
subplot(2, 2, 4);
hold on; 
plot(tasks, dens_sens_right_right, '-o', 'Color', 'green', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, dens_sens_left_right, '-o', 'Color', 'red', 'LineWidth', 2, 'MarkerSize', 8);
plot(tasks, dens_fp_right, '-ob', 'LineWidth', 2, 'MarkerSize', 8);   
plot(tasks, dens_all_right, '-ok', 'LineWidth', 2, 'MarkerSize', 8); 

% Aggiungere i valori vicino ai punti
for i = 1:length(tasks)
    text(tasks(i), dens_sens_right_right(i), sprintf('%.3f', dens_sens_right_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'green');
    text(tasks(i), dens_sens_left_right(i), sprintf('%.3f', dens_sens_left_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'red');
    text(tasks(i), dens_fp_right(i), sprintf('%.3f', dens_fp_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
    text(tasks(i), dens_all_right(i), sprintf('%.3f', dens_all_right(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'k');
end

hold off;
ylim([0.15 0.35]);
xlabel('Task');
ylabel('Network density');
grid on;

% Creazione di una legenda globale
hL = legend({'Sensori-motor (ipsilateral)', 'Sensori-motor (controlateral)', 'Fronto-Parietal', 'All electrodes'}, ...
            'Position', [0.5, 0.05, 0.01, 0.01], 'Units', 'normalized');
% Sposta la legenda fuori dai subplot
set(hL, 'Orientation', 'vertical'); % Legenda orizzontale

% Titolo generale per tutta la figura
sgtitle('EEG coherence in the beta band');