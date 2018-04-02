FROM uwgac/r343-topmed:master
RUN apt-get update && apt-get -y install git dstat

RUN git clone https://github.com/manning-lab/wgsaParsrWdl.git && cd ./wgsaParsrWdl && git pull origin master

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "devtools::install_git('https://github.com/UW-GAC/wgsaparsr.git', branch = 'master')"