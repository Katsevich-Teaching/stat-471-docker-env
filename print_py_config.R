function() {
  cat("R reticulate configuration\n")
  print(reticulate::py_config())
  cat(sprintf("R, Python tensorflow version: %s, %s\n",
              utils::packageVersion("tensorflow"),
              pypkg_version("tensorflow")))
  cat(sprintf("Python numpy version: %s\n",
              pypkg_version("numpy")))
  cat(sprintf("Python scipy version: %s\n",
              pypkg_version("scipy")))
  cat(sprintf("Python pillow version: %s\n",
              pypkg_version("PIL")))
  
}