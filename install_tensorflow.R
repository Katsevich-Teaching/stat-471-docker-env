install_tensorflow <- function() {
  tag  <- installation_target_tag()
  tested_combo <- tested_installation_combos[tag, ]
  if (is.na(tested_combo$os)) {
    stop(sprintf("install_miniconda: Unknown target %s.", tag))
  }
  
  miniconda_path <- reticulate::miniconda_path()
  conda  <- reticulate:::miniconda_conda(miniconda_path)
  
  if (tag == "darwin_arm64") {
    ## Install into r-reticulate environment
    args <- c("install", "-y", "-n r-reticulate", "-c apple", "tensorflow-deps")
    status <- system2(conda , args)
    if (status != 0)
      stop(sprintf("miniconda installation of tensorflow-deps failed [exit code %i]", status))
    
    python <- file.path(reticulate::miniconda_path(), "envs/r-reticulate/bin/python")
    args  <- c("-m pip", "install", "tensorflow-macos",
               paste0("pillow==", tested_combo$pillow),
               paste0("scipy==", tested_combo$scipy),
               paste0("numpy==", tested_combo$numpy))
    
    status <- system2(python, args)
    if (status != 0) {
      stop(sprintf("miniconda installation of tensorflow-macos failed [exit code %i]", status))
    } else {
      message("* Tensorflow for Mac M1 has been successfully installed.")
    }
  } else if (tag == "windows_x86_64") {
    ## Install into r-reticulate environment
    ## Save old path first before modifying
    old_path <- Sys.getenv("PATH")
    Sys.setenv(PATH = paste(conda_env_paths(miniconda_path), old_path, sep = ";"))
    tryCatch({
      reticulate::conda_install(
        envname = "r-reticulate",
        packages = paste0("tensorflow==", tested_combo$tensorflow),
        pip = TRUE,
        python_version = tested_combo$python)
      message("* Tensorflow for Windows x86_64 has been successfully installed.")
    },
    error = function(e) {
      message("* Tensorflow for Windows x86_64 could not be installed.")
    })
    ## Set old path back
    Sys.setenv(PATH = old_path)
  } else if (tag == "darwin_x86_64") {
    ## create r-reticulate environment and install into it
    args <- c("install", "-y", "-n r-reticulate",
              paste0("tensorflow==", tested_combo$tensorflow),
              paste0("pillow==", tested_combo$pillow),
              paste0("scipy==", tested_combo$scipy),
              paste0("numpy==", tested_combo$numpy))
    
    status <- system2(conda , args)
    
    if (status != 0) {
      stop(sprintf("miniconda installation of tensorflow failed [exit code %i]", status))
    } else {
      message("* Tensorflow for Mac x86_64 has been successfully installed.")
    }
  } else { ## linux
    tensorflow::install_tensorflow(
      version = tested_combo$tensorflow,
      conda_python_version = tested_combo$python
    )
  }
}