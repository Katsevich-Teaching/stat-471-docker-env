library(reticulate)
source(system.file("helpers", "install.R", package = "ISLR2"))
source("install_miniconda.R")
install_miniconda()
install_tensorflow()

print_py_config()
# sudo chmod a+r /usr/lib/x86_64-linux-gnu/libcuda*