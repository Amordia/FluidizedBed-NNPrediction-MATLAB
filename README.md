# Fluidized Bed Neural Network Prediction

This repository contains a MATLAB-based neural network model developed to predict particle concentration and gas concentration distribution in a fluidized bed. The model is part of an ongoing research project, and as such, not all code and data are available for public viewing.

## Background

Fluidized beds are a crucial component in several industrial processes, especially in the petrochemical industry. Predicting the behavior of particles and gas within these beds is essential for process optimization and safety considerations. Traditional models often rely on empirical correlations or complex computational fluid dynamics simulations. This project aims to leverage the power of neural networks to provide a faster, yet accurate, prediction tool.

## Technical Details

- **Data Interpolation (`Interpolation_Ug.m`)**: Before feeding data into the neural network, it's essential to have a consistent dataset. This script provides a method to interpolate missing data points, ensuring a uniform dataset for training and testing.

- **Noise Analysis (`Noise.m`)**: Neural networks can be sensitive to noise. This script provides a mechanism to analyze the dataset for potential noise and inconsistencies.

- **Outlier Detection (`Outlier_detection.m`)**: Outliers can significantly impact the performance of a neural network. This script uses Z-score based anomaly detection to identify and potentially remove outliers from the dataset.

- **Prediction (`Predict.m`)**: This script loads the trained neural network model and uses it to predict particle and gas concentration based on provided input parameters.

## Data and Code Availability

Due to the ongoing nature of this research, not all code files and data are available in this repository. We aim to release a more comprehensive version in the future once our research is finalized. We appreciate your understanding and patience.

## Usage

1. Ensure MATLAB is installed on your machine.
2. Clone the repository.
3. Navigate to the `scripts/` directory and run the desired script.

## Contributing

While contributions are welcome, please note that due to the sensitive nature of the ongoing research, not all pull requests can be merged. If you have suggestions or improvements, feel free to fork the repository and create a pull request. We'll review it at the earliest convenience.

## License

MIT License. See `LICENSE` for more details.
