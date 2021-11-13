FROM kuangda/stat-961 

# TODO： ^^^ change the source to ekatsevi/stat-961

COPY ISLR2_1.3.tar.gz .
RUN R -e "install.packages('ISLR2_1.3.tar.gz', repos=NULL, type = 'source')"
RUN R -e "install.packages('keras', repos = 'https://cloud.r-project.org')"

COPY install_miniconda.R .
COPY .Renviron .
RUN R -e "library(reticulate); \
    source(system.file('helpers', 'install.R', package = 'ISLR2')); \
    source('install_miniconda.R'); \
    install_miniconda(); install_tensorflow();" 

RUN R -e "install.packages('glmnet')"
RUN R -e "install.packages('randomForest')"
RUN R -e "install.packages('cowplot')"

COPY .Renviron /home/rstudio/.Renviron
COPY .Rprofile /home/rstudio/.Rprofile

COPY rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json
RUN chown -R rstudio:rstudio /home/rstudio/.config
