# WGSA parsr wdl dev

args <- commandArgs(trailingOnly=T)
source.file <- args[1]
config.file <- args[2]
destination <- args[3]
freeze <- args[4]
chunk.size <- args[5]
dbnsfp.destination <- args[6]

# wgsaParsr requires that if you are only parsing SNVs, you also parse dbnsfp, so. need to adjust config file to reflect this.
library(data.table)
config <- fread(config.file, data.table=F)

library(wgsaparsr)
if (sum(config$indel) > 0){
	parse_to_file(source_file = source.file,
              config = config.file,
              destination = destination,
              freeze = freeze,
              chunk_size = chunk.size,
              verbose = TRUE)
} else {
	config$dbnsfp[config$SNV] <- TRUE
	parse_to_file(source_file = source.file,
              config = config.file,
              destination = destination,
              dbnsfp_destination = dbnsfp_destination,
              freeze = freeze,
              chunk_size = chunk.size,
              verbose = TRUE)
}




