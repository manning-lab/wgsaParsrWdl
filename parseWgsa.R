# WGSA parsr wdl dev

args <- commandArgs(trailingOnly=T)
source_file <- args[1]
config_file <- args[2]
destination <- args[3]
freeze <- args[4]
chunk_size = args[5]

library(wgsaparsr)

parse_to_file(source_file = source_file,
              config = config_file,
              destination = destination,
              freeze = freeze,
              chunk_size = chunk_size,
              verbose = TRUE)
