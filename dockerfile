FROM kuangda/stat-961
COPY ISLR2_1.3.tar.gz .
RUN R -e "install.packages('ISLR2_1.3.tar.gz', repos=NULL, type = 'source')"
RUN R -e "install.packages('keras', repos = 'https://cloud.r-project.org')"

COPY install_miniconda.R .
COPY .Renviron .
RUN R -e "library(reticulate); \
    source(system.file('helpers', 'install.R', package = 'ISLR2')); \
    source('install_miniconda.R'); \
    install_miniconda(); install_tensorflow();" 

# Install Cuda 11 driver for Linux Ubuntu 20.04 x86_64
# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local
# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=arm64-sbsa&Compilation=Native&Distribution=Ubuntu&target_version=20.04&target_type=deb_local
RUN apt-get update && apt-get install -y gnupg2
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
RUN mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN wget https://developer.download.nvidia.com/compute/cuda/11.5.0/local_installers/cuda-repo-ubuntu2004-11-5-local_11.5.0-495.29.05-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu2004-11-5-local_11.5.0-495.29.05-1_amd64.deb
RUN apt-key add /var/cuda-repo-ubuntu2004-11-5-local/7fa2af80.pub
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install cuda

RUN R -e "install.packages('glmnet')"

# # Deal with CUDA LD warning
# # https://stackoverflow.com/questions/64193633/could-not-load-dynamic-library-libcublas-so-10-dlerror-libcublas-so-10-cann
# RUN PATH="/usr/lib/x86_64-linux-gnu${PATH:+:${PATH}}"
# RUN LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
# RUN chmod 777 /usr/lib/x86_64-linux-gnu/libcuda*

COPY .Renviron /home/rstudio/.Renviron
