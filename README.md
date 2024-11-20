# Linear Regression Package

This R package provides a simple and efficient implementation of linear regression, including the calculation of regression coefficients, residuals, Mean Squared Error (MSE), R-squared, adjusted R-squared, standard errors of coefficients, t-statistics, p-values, and F-statistic. The package also includes diagnostic plots to evaluate model assumptions and a function to print all outputs.

## Table of Contents

-   [Installation](#installation)
-   [Functions](#functions)
    -   [linear_regression](#linear_regression)
    -   [print_regression_summary](#print_regression_summary)
-   [Usage](#usage)
-   [Features](#features)
-   [Example](#example)
-   [Testing](#testing)
-   [License](#license)

## Installation {#installation}

To install this package from GitHub, use the following commands:

``` r
# Install devtools if you haven't already
install.packages("devtools")

# Install the package from GitHub
devtools::install_github("ZYLwayne/YileZhu-Biostat625-HW3-LinearRegression")
```

## Functions {#functions}

### linear_regression {#linear_regression}

**Description**: Fits a linear regression model using Ordinary Least Squares (OLS) and returns an output list containing various regression statistics and diagnostics.

-   **Inputs**:

    -   `X`: A matrix of predictor variables, where the first column is 1s for the intercept.

    -   `Y`: A vector of the response variable.

-   **Outputs**:

    -   `coefficients`: Estimated regression coefficients.

    -   `fitted_values`: Predicted values of the response variable.

    -   `residuals`: Differences between observed and predicted values.

    -   `mse`: Mean Squared Error of the model.

    -   `r_squared`: R-squared value.

    -   `adj_r_squared`: Adjusted R-squared value.

    -   `std_errors`: Standard errors of the coefficients.

    -   `t_statistics`: t-statistics for the coefficients.

    -   `p_values`: p-values for the coefficients.

    -   `f_statistic`: F-statistic for overall model significance.

    -   `df1`: Degrees of freedom for the regression.

    -   `df2`: Degrees of freedom for the residuals.

    -   `diagnostic_plots`: Diagnostic plots for model assessment.

### print_regression_summary {#print_regression_summary}

**Description**: Prints a comprehensive summary of the linear regression output, including all key metrics and diagnostic information.

-   **Input**:

    -   `results`: The output list from the `linear_regression` function.

-   **Output**: A formatted printout of the regression analysis summary.

## Usage {#usage}

To use the package, follow these steps:

1.  Load your data and prepare the predictor matrix `X` and response vector `Y`.

2.  Use the `linear_regression` function to perform the analysis.

3.  Use the `print_regression_summary` function to print the results.

## Features {#features}

-   Computes regression coefficients, residuals, and diagnostic metrics.

-   Generates diagnostic plots to evaluate model assumptions.

-   Provides comprehensive statistical outputs, including R-squared, adjusted R-squared, and p-values.

-   Includes a convenient function to print all results in a user-friendly format.

## Example {#example}

Here is an example of how to use the functions in this package:

``` r
# Load your package
library(HW3LR)

# Load your data
my_data <- read.csv("path/to/your/test.csv")

# Prepare the data
Y <- my_data$y  # Response variable
X <- cbind(1, my_data$x)  # Predictor matrix including the intercept term

# Perform linear regression
results <- linear_regression(X, Y)

# Print the regression summary
print_regression_summary(results)
```

## Testing {#testing}

To ensure that your package functions correctly, you can use the `testthat` framework. Here’s how to set up and run your tests:

1.  **Set up `testthat`**:

    ``` r
    usethis::use_testthat()
    ```

2.  **Create a test file**:

    -   In the `tests/testthat` directory, create a file named `test-linear_regression.R`.

3.  **Write your test cases**:

    ``` r
    # tests/testthat/test-linear_regression.R

    library(testthat)
    library(HW3LR)  

    # Read the sample dataset
    my_data <- read.csv("C:\\HW3LR\\test.csv")  # Replace with the path to your dataset

    # Prepare the predictor matrix X and the response variable Y
    Y <- my_data$y  # Response variable
    X <- cbind(1, my_data$x)  # Create the X matrix including the intercept term

    # Define the results object in each test case
    test_that("linear_regression computes coefficients correctly", {
      # Call your linear regression function
      results <- linear_regression(X, Y)

      # Check if the length of the regression coefficients is correct
      expect_equal(length(results$coefficients), ncol(X), info = "Coefficient length mismatch")

      # Check if R-squared is within the valid range
      expect_true(results$r_squared >= 0 && results$r_squared <= 1, info = "R-squared out of bounds")

      # Check if the Mean Squared Error (MSE) is non-negative
      expect_true(results$mse >= 0, info = "MSE should be non-negative")
    })

    test_that("linear_regression generates diagnostic plots", {
      # Define the results object again here
      results <- linear_regression(X, Y)

      # Verify that the diagnostic plots have been generated
      expect_output(print(results$diagnostic_plots), "Diagnostic plots have been generated.")
    })
    ```

4.  **Run the tests**:

    ``` r
    devtools::test()
    ```

## License 

This package is licensed under the MIT License.
