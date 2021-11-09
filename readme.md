# Stat 471 Docker Env

This is the repository for building Wharton STAT 471's docker environment.

## Working log

- R version is 4.0.3, which is inherited from [STAT 961 Docker Env](https://hub.docker.com/r/kuangda/stat-961).
- `ISLR2` cannot be found in CRAN so it is installed by source.
- `install_miniconda()` has a bug so a modified version is created in `./install_miniconda.R`.

## Progress

- Docker Env is able to run deep learning examples in ISLR2 book.
- Docker Env is able to compile Rnw file from Stat 961.

## Known Issue

- Now the compuation is on CPU. We need to integrate NVIDIA Container Toolkit into the environment to have the code run on GPU.
