%% connectivity (coherence)
% load dataset EEG
EEG = pop_loadset('filename', 'epochs4.set');

% Estrarre i dati EEG (matrice: canali x tempo)
data = EEG.data; % Dimensioni: (canali x campioni x trial)

% Se i dati hanno più trial, li concateno lungo il tempo
if ndims(data) == 3
    data = reshape(data, size(data,1), []); % Concatena tutti i trials
end

% Parametri per mscohere
fs = EEG.srate; % Frequenza di campionamento
freq_band = [13 30]; % Banda alpha (modifica se necessario)
num_channels = size(data, 1);

% Inizializzare la matrice di coerenza
coh_matrix = zeros(num_channels);

% Calcolare la coerenza per ogni coppia di canali
for i = 1:num_channels
    for j = i:num_channels % Solo triangolo superiore (simmetrico)
        [coh, f] = mscohere(data(i,:), data(j,:), [], [], [], fs);
        alpha_idx = (f >= freq_band(1) & f <= freq_band(2)); % Indici della banda alpha
        coh_matrix(i, j) = mean(coh(alpha_idx)); % Media della coerenza nella banda alpha
        coh_matrix(j, i) = coh_matrix(i, j); % Simmetrico
    end
end

% Ottenere i nomi dei canali EEG
channel_labels = string({EEG.chanlocs.labels}); 

% Visualizzare la matrice di coerenza
figure;
imagesc(coh_matrix);
colorbar;
title('Matrice di Connettività - Coerenza (Banda Alpha)');
xlabel('Canali EEG');
ylabel('Canali EEG');

% Impostare i nomi dei canali sugli assi X e Y
set(gca, 'XTick', 1:num_channels, 'XTickLabel', channel_labels, ...
         'YTick', 1:num_channels, 'YTickLabel', channel_labels, ...
         'XTickLabelRotation', 45); % Ruota le etichette per leggibilità

% Migliorare la visualizzazione
axis square; % Mantiene la matrice quadrata
colormap jet; % Usa la colormap jet per una visualizzazione migliore


%% Grafo della connettività EEG
% Impostare una soglia per visualizzare solo connessioni forti
threshold = 0.4; % Modifica la soglia a seconda del dataset
adj_matrix = coh_matrix .* (coh_matrix > threshold); % Mantiene solo connessioni forti

% Estrarre le coordinate reali degli elettrodi
x = [EEG.chanlocs.X]'; % Coordinate X
y = [EEG.chanlocs.Y]'; % Coordinate Y
labels = channel_labels'; % Nomi degli elettrodi

% Creare la figura del grafo
figure; hold on;
axis equal;
title('Rete di Connettività EEG con Coerenza (Banda Alpha)');

% Plottare gli elettrodi come nodi
scatter(x, y, 100, 'filled', 'k'); % Nodi neri

% Etichette dei nodi (elettrodi)
for i = 1:num_channels
    text(x(i), y(i), labels(i), 'FontSize', 10, 'Color', 'k', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end

% Plottare le connessioni con colori basati sulla coerenza
[i_idx, j_idx] = find(triu(adj_matrix)); % Trova connessioni nella metà superiore
coh_values = adj_matrix(i_idx + (j_idx-1) * size(adj_matrix,1)); % Valori di coerenza

% Normalizzare i valori di coerenza per la colorazione (tra 0 e 1)
coh_norm = (coh_values - min(coh_values)) / (max(coh_values) - min(coh_values));

% Creare una mappa di colori (dal blu al rosso)
colors = [coh_norm, zeros(size(coh_norm)), 1 - coh_norm]; % Da blu (bassa coerenza) a rosso (alta coerenza)

% Disegnare le connessioni colorate
for k = 1:length(i_idx)
    i = i_idx(k);
    j = j_idx(k);
    plot([x(i), x(j)], [y(i), y(j)], 'Color', colors(k, :), 'LineWidth', 1);
end

% Aggiungere una legenda con la barra dei colori
colormap('jet'); % Usa una mappa di colori (dal blu al rosso)
colorbar;
caxis([min(coh_values), max(coh_values)]);
ylabel(colorbar, 'Coerenza (Banda Alpha)');

hold off;

%% Distribuzione delle connessioni per nodo (Degree)
% Soglia la matrice di connettività per creare una rete binaria
binary_matrix = coh_matrix > threshold;

% Calcola il degree (numero di connessioni per nodo)
degree = sum(binary_matrix, 2);

% Visualizza la distribuzione del degree
figure;
bar(degree);
set(gca, 'XTick', 1:length(channel_labels), 'XTickLabel', channel_labels, 'XTickLabelRotation', 45); % Ruota le etichette di 45° per visibilità
xlabel('Canale EEG');
ylabel('Degree');
title('Distribuzione delle Connessioni per Canale');
grid on;

%% metriche
mean_coh = mean(coh_matrix(:)); % Media su tutti i valori della matrice di coerenza
density = sum(binary_matrix(:)) / (num_channels * (num_channels - 1));

fprintf('Mean coherence: %.3f\n', mean_coh);
fprintf('Network density: %.3f\n', density);

%% elettrodi sensori-motori e parietali
% Definire gli elettrodi di interesse
sensorimotor_electrodes = ["C3", "C4", "Cz", "Cp3", "Cp4", "Fc3", "Fc4"];
frontoparietal_electrodes = ["F3", "F4", "Fc1", "Fc2", "P3", "P4", "Cp1", "Cp2", "Pz"];

% Ottieni gli indici corrispondenti agli elettrodi nel dataset
sensorimotor_idx = find(ismember({EEG.chanlocs.labels}, sensorimotor_electrodes));
frontoparietal_idx = find(ismember({EEG.chanlocs.labels}, frontoparietal_electrodes));

%% Coherence per i soli elettrodi sensorimotori
coh_matrix_sens = coh_matrix(sensorimotor_idx, sensorimotor_idx);
adj_matrix_sens = adj_matrix(sensorimotor_idx,sensorimotor_idx);
plot_connectivity(x(sensorimotor_idx), y(sensorimotor_idx), labels(sensorimotor_idx), adj_matrix_sens, 'Connettività Sensorimotoria (Banda Alpha)');

%% Coherence per i soli elettrodi fronto-parietali
coh_matrix_fp = coh_matrix(frontoparietal_idx, frontoparietal_idx);
adj_matrix_fp = adj_matrix(frontoparietal_idx,frontoparietal_idx);
plot_connectivity(x(frontoparietal_idx), y(frontoparietal_idx), labels(frontoparietal_idx), adj_matrix_fp, 'Connettività Fronto-Parietale (Banda Alpha)');

%% Distribuzione delle connessioni (Degree) per ogni subset
figure;
%degree_sens = sum(adj_matrix_sens > 0, 2);
degree_sens = degree(sensorimotor_idx,1);
bar(degree_sens);
set(gca, 'XTick', 1:length(sensorimotor_idx), 'XTickLabel', labels(sensorimotor_idx), 'XTickLabelRotation', 45);
xlabel('Canale EEG (Sensorimotor)');
ylabel('Degree');
title('Distribuzione delle Connessioni (Sensorimotor)');
grid on;

figure;
%degree_fp = sum(adj_matrix_fp > 0, 2);
degree_fp = degree(frontoparietal_idx,1);
bar(degree_fp);
set(gca, 'XTick', 1:length(frontoparietal_idx), 'XTickLabel', labels(frontoparietal_idx), 'XTickLabelRotation', 45);
xlabel('Canale EEG (Fronto-Parietale)');
ylabel('Degree');
title('Distribuzione delle Connessioni (Fronto-Parietale)');
grid on;

%% Metriche di connettività per ciascun subset
mean_coh_sens = mean(coh_matrix_sens(:));
density_sens = sum(adj_matrix_sens(:)) / (length(sensorimotor_idx) * (length(sensorimotor_idx) - 1));

mean_coh_fp = mean(coh_matrix_fp(:));
density_fp = sum(adj_matrix_fp(:)) / (length(frontoparietal_idx) * (length(frontoparietal_idx) - 1));

fprintf('Mean coherence (Sensorimotor): %.3f\n', mean_coh_sens);
fprintf('Network density (Sensorimotor): %.3f\n', density_sens);
fprintf('Mean coherence (Fronto-Parietal): %.3f\n', mean_coh_fp);
fprintf('Network density (Fronto-Parietal): %.3f\n', density_fp);

%% Funzione per plottare la rete di connettività
% Function for plotting connectivity network
function plot_connectivity(x, y, labels, adj_matrix, title_str)
    figure; hold on;
    axis equal;
    title(title_str);

    % Plot electrodes as nodes
    scatter(x, y, 100, 'filled', 'k'); % Black nodes

    % Label the electrodes
    for i = 1:length(labels)
        text(x(i), y(i), labels(i), 'FontSize', 10, 'Color', 'k', ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end

    % Extract strong connections
    [i_idx, j_idx] = find(triu(adj_matrix));
    coh_values = adj_matrix(sub2ind(size(adj_matrix), i_idx, j_idx));

    % Avoid division by zero in normalization
    if max(coh_values) - min(coh_values) == 0
        coh_norm = ones(size(coh_values)); % Assign uniform color
        color_range = [0, 1]; % Default color scale range
    else
        coh_norm = (coh_values - min(coh_values)) / (max(coh_values) - min(coh_values));
        color_range = [min(coh_values), max(coh_values)];
    end

    % Define color map (blue to red)
    colors = [coh_norm, zeros(size(coh_norm)), 1 - coh_norm];

    % Draw colored connections
    for k = 1:length(i_idx)
        i = i_idx(k);
        j = j_idx(k);
        plot([x(i), x(j)], [y(i), y(j)], 'Color', colors(k, :), 'LineWidth', 1);
    end

    % Color bar for reference
    colormap('jet');
    colorbar;
    caxis(color_range); % Set proper color scale
    ylabel(colorbar, 'Coherence (Alpha Band)');

    hold off;
end