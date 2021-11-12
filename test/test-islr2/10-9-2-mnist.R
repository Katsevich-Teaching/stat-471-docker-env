library(keras)
mnist <- dataset_mnist()
x_train <- mnist$train$x
g_train <- mnist$train$y
x_test <- mnist$test$x
g_test <- mnist$test$y
dim(x_train)
dim(x_test)


x_train <- array_reshape(x_train, c(nrow(x_train), 784))
x_test <- array_reshape(x_test, c(nrow(x_test), 784))
y_train <- to_categorical(g_train, 10)
y_test <- to_categorical(g_test, 10)

x_train <- x_train / 255
x_test <- x_test / 255


modelnn <- keras_model_sequential()
modelnn %>%
  layer_dense(
    units = 256, activation = "relu",
    input_shape = c(784)
  ) %>%
  layer_dropout(rate = 0.4) %>%
  layer_dense(units = 128, activation = "relu") %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units = 10, activation = "softmax")

summary(modelnn)

modelnn %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_rmsprop(), metrics = c("accuracy")
)

system.time(
  history <- modelnn %>%
    fit(x_train, y_train,
      epochs = 30, batch_size = 128,
      validation_split = 0.2
    )
)
# user  system elapsed 
# 252.542  27.148  40.708 
plot(history , smooth = FALSE)

# 2021-11-08 23:45:24.527966: I tensorflow/compiler/mlir/mlir_graph_optimization_pass.cc:176] None of the MLIR Optimization Passes are enabled (registered 2)
# 2021-11-08 23:45:24.548230: I tensorflow/core/platform/profile_utils/cpu_utils.cc:114] CPU Frequency: 2894605000 Hz
# 
# None of the MLIR Optimization Passes are enabled is a bit misleading as it refers to very particular workflow. But it is benign and has no effect - it just means a user didn’t opt in to a specific pass (which is not enabled by default), so it doesn’t indicate any error and was rather used as signal for developers. But seeing this, it is causing more confusion. I’ll go and update the message.
# 
# 
# 
# https://discuss.tensorflow.org/t/none-of-the-mlir-optimization-passes-are-enabled/2247/14