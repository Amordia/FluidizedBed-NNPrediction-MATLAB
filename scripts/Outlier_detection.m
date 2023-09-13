% Load the combined data
combined_data = readmatrix('Combined_Input_Predicted_Output.xlsx');

% 1. Z-score based anomaly detection
z_scores = zscore(combined_data);
z_threshold = 3; % common threshold
outliers_zscore = find(any(abs(z_scores) > z_threshold, 2));

% Display indices of outliers based on Z-score
disp('Outliers based on Z-score:');
disp(outliers_zscore);

% 2. One-Class SVM based anomaly detection
% Ensure you have the Statistics and Machine Learning Toolbox
rng('default'); % For reproducibility
ocsvm_model = fitcsvm(combined_data, ones(size(combined_data, 1), 1), 'KernelScale', 'auto', 'Standardize', true, 'OutlierFraction', 0.05);
[outliers_ocsvm_score, ~] = predict(ocsvm_model, combined_data);
outliers_ocsvm = find(outliers_ocsvm_score == -1);

% Display indices of outliers based on One-Class SVM
disp('Outliers based on One-Class SVM:');
disp(outliers_ocsvm);

% Visualize outliers
all_outliers = unique([outliers_zscore; outliers_ocsvm]);
num_outliers = length(all_outliers);
num_features = size(combined_data, 2);

for i = 1:num_outliers
    subplot(num_outliers, 1, i);
    bar(combined_data(all_outliers(i), :));
    xlim([0, num_features+1]);
    title(['Outlier at index ', num2str(all_outliers(i))]);
end

% Increase the figure size for better visibility
set(gcf, 'Position', [100, 100, 600, 400*num_outliers]);

% Extract rows with outliers
outliers_rows = combined_data(all_outliers, :);

% Save the rows with outliers to a CSV file
writematrix(outliers_rows, 'Outliers.csv');