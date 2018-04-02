task parse {
	File source_file
	File config_file
	String destination
	Int freeze
	Int chunk_size

	Int disk 
	Int memory

	command {
		echo "Input files" > parse_out.log
		echo "WGSA input file : ${source_file}" >> parse_out.log
		echo "Configuration file : ${config_file}" >> parse_out.log
		echo "Output file : ${destination}" >> parse_out.log
		echo "Freeze number : ${freeze}" >> parse_out.log
		echo "Chunk size: ${chunk_size}" >> parse_out.log
		echo "memory: ${memory}" >> parse_out.log
		echo "disk: ${disk}" >> parse_out.log
		echo "" >> parse_out.log
		dstat -c -d -m --nocolor 10 1>>parse_out.log &
    	R --vanilla --args ${source_file} ${config_file} ${destination} ${freeze} ${chunk_size} < ./parseWgsa.R
    }

    meta {
            author: "TM"
            email: "tmajaria@broadinstitute.org"
    }

    runtime {
    	   docker: "manninglab/wgsaparsrwdl:latest"
		   disks: "local-disk ${disk} SSD"
		   memory: "${memory}G"
    }

    output {
    	File out_file = "${destination}"
    	File log_file = "parse_out.log"
    }	

}

workflow parseWgsa {
	File this_source_file
	File this_config_file
	String this_destination
	Int this_freeze
	Int this_chunk_size

	Int this_disk
	Int this_memory

	call parse {
		input: source_file = this_source_file, config_file = this_config_file, destination = this_destination, freeze = this_freeze, chunk_size = this_chunk_size, disk = this_disk, memory = this_memory
	}
}
