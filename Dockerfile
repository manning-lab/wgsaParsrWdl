FROM uwgac/r343-topmed:master
RUN apt-get update && apt-get -y install git dstat

RUN git clone https://github.com/manning-lab/wgsaParsrWdl.git && cd ./wgsaParsrWdl && git checkout init_wdl && git pull origin init_wdl

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages(c('devtools','data.table'))"
RUN Rscript -e "devtools::install_git('https://github.com/UW-GAC/wgsaparsr.git', branch = 'master')"

ADD ./test_data/* ./wgsaParsrWdl/test_data/