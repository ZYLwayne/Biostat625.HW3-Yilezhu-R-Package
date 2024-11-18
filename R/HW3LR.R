#' @title Perform Linear Regression Analysis
#' @description
#' This function performs a linear regression analysis, calculating key metrics
#' such as point estimates, fitted values, residuals, mean squared error (MSE),
#' R-squared, adjusted R-squared, standard errors of coefficients, t-statistics,
#' p-values, F-statistic, degrees of freedom, and diagnostic plots.
#'
#' @param X A matrix of predictor variables, with the first column as 1s for the intercept.
#' @param Y A numeric vector of the response variable.
#' @return A list containing:
#'   - `coefficients`: The estimated regression coefficients.
#'   - `fitted_values`: The predicted values from the regression model.
#'   - `residuals`: The difference between observed and fitted values.
#'   - `mse`: The mean squared error of the model.
#'   - `r_squared`: The coefficient of determination.
#'   - `adj_r_squared`: The adjusted R-squared value.
#'   - `standard_errors`: The standard errors of the estimated coefficients.
#'   - `t_statistics`: The t-statistics for each coefficient.
#'   - `p_values`: The p-values for each t-statistic.
#'   - `f_statistic`: The F-statistic for the overall model.
#'   - `df1`: The degrees of freedom for the model.
#'   - `df2`: The degrees of freedom for the residuals.
#'   - `diagnostic_plots`: A message indicating that diagnostic plots have been generated.
#' @export
linear_regression <- function(X, Y) {
  # Check dimensions of X and Y
  if (nrow(X) != length(Y)) {
    stop("The number of rows in X must match the length of Y.")
  }

  # Calculate regression coefficients using OLS
  beta_hat <- solve(t(X) %*% X) %*% t(X) %*% Y

  # Calculate fitted values and residuals
  fitted_values <- X %*% beta_hat
  residuals <- Y - fitted_values

  # Compute mean squared error (MSE)
  mse <- mean(residuals^2)

  # Compute total sum of squares (SST) and residual sum of squares (SSR)
  sst <- sum((Y - mean(Y))^2)
  ssr <- sum(residuals^2)

  # Calculate R-squared and adjusted R-squared
  r_squared <- 1 - (ssr / sst)
  n <- length(Y)  # Number of observations
  p <- ncol(X)    # Number of predictors including the intercept
  adj_r_squared <- 1 - ((1 - r_squared) * (n - 1) / (n - p))

  # Calculate standard errors of the coefficients
  sigma_sq <- ssr / (n - p)
  variance_beta <- sigma_sq * solve(t(X) %*% X)
  standard_errors <- sqrt(diag(variance_beta))

  # Calculate t-statistics and p-values
  t_statistics <- beta_hat / standard_errors
  p_values <- 2 * pt(-abs(t_statistics), df = n - p)

  # Compute F-statistic
  f_statistic <- ((sst - ssr) / (p - 1)) / (ssr / (n - p))

  # Degrees of freedom
  df1 <- p - 1
  df2 <- n - p

  # Generate diagnostic plots
  # Plot 1: Residuals vs Fitted Values
  plot(fitted_values, residuals, main = "Residuals vs Fitted",
       xlab = "Fitted Values", ylab = "Residuals", pch = 20, col = "blue")
  abline(h = 0, lty = 2, col = "red")

  # Plot 2: QQ Plot of Residuals
  qqnorm(residuals, main = "QQ Plot of Residuals")
  qqline(residuals, col = "red")

  # Plot 3: Actual vs Predicted Values
  plot(Y, fitted_values, main = "Actual vs Predicted Values",
       xlab = "Actual Values", ylab = "Predicted Values", pch = 20, col = "green")
  abline(0, 1, col = "red")

  # Return all computed metrics and diagnostic information
  return(list(
    coefficients = as.vector(beta_hat),
    fitted_values = fitted_values,
    residuals = residuals,
    mse = mse,
    r_squared = r_squared,
    adj_r_squared = adj_r_squared,
    standard_errors = standard_errors,
    t_statistics = t_statistics,
    p_values = p_values,
    f_statistic = f_statistic,
    df1 = df1,
    df2 = df2,
    diagnostic_plots = "Diagnostic plots have been generated."
  ))
}

#' Print Regression Summary
#'
#' This function takes the output from `linear_regression` and prints
#' all the important statistics and diagnostic information in a readable format.
#'
#' @param results A list returned by the `linear_regression` function.
#' @export
print_regression_summary <- function(results) {
  cat("======= Linear Regression Summary =======\n")

  # Print regression coefficients
  cat("\nRegression Coefficients:\n")
  print(results$coefficients)

  # Print fitted values (showing the first 5 values)
  cat("\nFitted Values (First 5):\n")
  print(head(results$fitted_values))

  # Print residuals (showing the first 5 values)
  cat("\nResiduals (First 5):\n")
  print(head(results$residuals))

  # Print mean squared error (MSE)
  cat("\nMean Squared Error (MSE):\n")
  print(results$mse)

  # Print R-squared and Adjusted R-squared
  cat("\nR-squared:\n")
  print(results$r_squared)
  cat("\nAdjusted R-squared:\n")
  print(results$adj_r_squared)

  # Print standard errors of coefficients
  cat("\nStandard Errors:\n")
  print(results$standard_errors)

  # Print t-statistics for each coefficient
  cat("\nt-statistics:\n")
  print(results$t_statistics)

  # Print p-values for each coefficient
  cat("\np-values:\n")
  print(results$p_values)

  # Print F-statistic and degrees of freedom
  cat("\nF-statistic:\n")
  print(results$f_statistic)
  cat("\nDegrees of Freedom (df1, df2):\n")
  print(c(results$df1, results$df2))

  # Print diagnostic plot message
  cat("\nDiagnostic Plots:\n")
  cat(results$diagnostic_plots, "\n")

  cat("=========================================\n")
}
