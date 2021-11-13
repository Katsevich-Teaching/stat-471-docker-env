# start from teaching-base image
FROM ekatsevi/teaching-base 

# install ISLR2 from source
COPY ISLR2_1.3.tar.gz .
RUN R -e "install.packages('ISLR2_1.3.tar.gz', repos=NULL, type = 'source')"

# install keras
RUN R -e "install.packages('keras', repos = 'https://cloud.r-project.org')"

# install reticulate, miniconda, tensorflow 
COPY install_miniconda.R .
COPY .Renviron .
RUN R -e "library(reticulate); \
    source(system.file('helpers', 'install.R', package = 'ISLR2')); \
    source('install_miniconda.R'); \
    install_miniconda(); install_tensorflow();" 
COPY .Renviron /home/rstudio/.Renviron

### install additional R packages ###

# wrangling
RUN R -e "install.packages('lubridate')"    # working with dates
RUN R -e "install.packages('modelr')"       # wranging models

# plotting/presentation
RUN R -e "install.packages('cowplot')"      # side-by-side plots
RUN R -e "install.packages('GGally')"       # nice pairs plots
RUN R -e "install.packages('ggrepel')"      # repelling point labels
RUN R -e "install.packages('kableExtra')"   # for nice tables
RUN R -e "install.packages('maps')"         # for plotting maps in ggplot
RUN R -e "install.packages('pROC')"         # for ROC curves
RUN R -e "install.packages('scales')"       # for adjusting ggplot scales

# learning
RUN R -e "install.packages('FNN')"           # KNN
RUN R -e "install.packages('gbm')"           # boosting
RUN R -e "install.packages('glmnet')"        # penalized regression
RUN R -e "install.packages('glmnetUtils')"   # penalized regression with formulas
RUN R -e "install.packages('randomForest')"  # random forests
RUN R -e "install.packages('rpart')"         # classification and regression trees
RUN R -e "install.packages('rpart.plot')"    # plotting for decision trees

# set global options for RStudio (initial working directory, Sweave options)
COPY --chown=rstudio:rstudio rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json