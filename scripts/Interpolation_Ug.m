% Load data from Excel file
data = readmatrix('Data2.xlsx');

% Separate the input and output data
% Remove the C/C0 column as per your instruction
input_data = data(:, 1:end-1);
output_data = data(:, end);

% Define which columns to interpolate
columns_to_interpolate = find(strcmp(headers, 'Ug'));

% Interpolation
num_points = size(input_data, 1);
interpolation_factor = 2; % Increase this for more interpolation points
new_num_points = (num_points-1) * interpolation_factor + 1;

% Prepare the interpolated data matrix with the new dimensions
interpolated_input = zeros(new_num_points, size(input_data, 2));

% Copy non-interpolated columns directly
for col = 1:size(input_data, 2)
    if ~ismember(col, columns_to_interpolate)
        interpolated_input(:, col) = interp1(1:num_points, input_data(:, col), linspace(1, num_points, new_num_points), 'nearest');
    end
end

% Interpolate selected columns with uniform distribution
epsilon = 1e-10; % Small noise level
for col = columns_to_interpolate
    x = 1:num_points;
    y = input_data(:, col);
    
    % Apply a non-linear mapping to the data (e.g., square root)
    y_mapped = sqrt(y - min(y) + 1);  % Ensure the values are positive before taking the square root
    
    % Interpolation on the mapped data
    xi = linspace(1, num_points, new_num_points);
    yi_mapped = interp1(x, y_mapped, xi, 'spline');
    
    % Reverse the mapping
    yi = (yi_mapped.^2) + min(y) - 1;
    
    interpolated_input(:, col) = yi;
end

% Load the regression model
load('RegressionModel_Ug.mat', 'trainedModel');

% Convert the interpolated input data to a table
input_table = array2table(interpolated_input, 'VariableNames', trainedModel.RequiredVariables);

% Predict the output for the interpolated input data using the model
predicted_output = trainedModel.predictFcn(input_table);

% Visualization for the selected columns
for col = columns_to_interpolate
    figure;
    plot(data(:, col), 'o', 'DisplayName', '原始数据');
    hold on;
    plot(interpolated_input(:, col), '.', 'DisplayName', '插值数据');
    title(['列 ' num2str(col) ' 的数据']);
    legend;
    hold off;
end

% Plot output data
figure;
plot(output_data, 'o', 'DisplayName', '原始数据');
hold on;
plot(predicted_output, '.', 'DisplayName', '预测数据');
title('输出数据');
legend;
hold off;
