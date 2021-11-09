FROM kuangda/stat-961

COPY ISLR2_1.3.tar.gz .
RUN R -e "install.packages('ISLR2_1.3.tar.gz', repos=NULL, type = 'source')"
RUN R -e "install.packages('keras', repos = 'https://cloud.r-project.org')"

COPY install_miniconda.R .
RUN R -e "library(reticulate); \
    source(system.file('helpers', 'install.R', package = 'ISLR2')); \
    source('install_miniconda.R'); \
    install_miniconda(); install_tensorflow();" 

# Install Cuda driver
RUN apt-get update
RUN apt install nvidia-cuda-toolkit -y

# Deal with CUDA LD warning
# https://stackoverflow.com/questions/64193633/could-not-load-dynamic-library-libcublas-so-10-dlerror-libcublas-so-10-cann
RUN PATH="/usr/lib/x86_64-linux-gnu${PATH:+:${PATH}}"
RUN LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
RUN chmod a+r /usr/lib/x86_64-linux-gnu/libcuda*

RUN R -e "install.packages('glmnet')"
