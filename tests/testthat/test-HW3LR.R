# tests/testthat/test-linear_regression.R

library(testthat)
library(HW3LR)  # 替换为你的实际包名

# 读取示例数据集
my_data <- read.csv("C:\\HW3LR\\test.csv")  # 替换为你的数据集路径

# 准备自变量矩阵 X 和因变量 Y
Y <- my_data$y  # 因变量
X <- cbind(1, my_data$x)  # 创建包含截距项的 X 矩阵

# 在每个测试用例中定义 results 对象
test_that("linear_regression computes coefficients correctly", {
  # 调用你的线性回归函数
  results <- linear_regression(X, Y)

  # 检查回归系数长度是否正确
  expect_equal(length(results$coefficients), ncol(X), info = "Coefficient length mismatch")

  # 检查 R-squared 是否在合理范围内
  expect_true(results$r_squared >= 0 && results$r_squared <= 1, info = "R-squared out of bounds")

  # 检查残差均方误差 (MSE) 是否为非负数
  expect_true(results$mse >= 0, info = "MSE should be non-negative")
})

test_that("linear_regression generates diagnostic plots", {
  # 在这里再次定义 results 对象
  results <- linear_regression(X, Y)

  # 验证诊断图是否已生成
  expect_output(print(results$diagnostic_plots), "Diagnostic plots have been generated.")
})
