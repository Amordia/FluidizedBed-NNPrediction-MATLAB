% Load the data from the Excel file
data = xlsread('Data2.xlsx');

% Find the column index for 'Ug'
[~, headers] = xlsread('Data2.xlsx', 'A1:Z1');
ug_col = find(strcmp(headers, 'Ug'));

% Add a small Gaussian noise to the 'Ug' column
noise_std = 0.01; % You can adjust this value as needed
data(:, ug_col) = data(:, ug_col) + noise_std * randn(size(data, 1), 1);

% Save the modified data to a new Excel file
xlswrite('Data2_NoiseAdded.xlsx', [headers; num2cell(data)]);