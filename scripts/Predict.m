% Load the interpolated input data
interpolated_data = readmatrix('Interpolated_Data4.xlsx');
input_data = interpolated_data(:, 1:end-1);

% Convert the interpolated input data to a table
input_table = array2table(input_data, 'VariableNames', trainedModel.RequiredVariables);

% Predict the output using the provided function
predicted_output = trainedModel.predictFcn(input_table);

% Combine input data and predicted output
combined_data = [input_data, predicted_output];

% Save the combined data to an Excel file
writematrix(combined_data, 'Combined_Input_Predicted_Output.xlsx');