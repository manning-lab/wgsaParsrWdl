task parse {
	File anno
	String label
	String chr
	String desired_columns
	String columns_to_split
	File script

	Int? disk = 100
	Int? mem = 10

	command {
        	R --vanilla --args ${anno} ${label} ${desired_columns} ${columns_to_split} < ${script}
    }

    meta {
            author: "TM"
            email: "tmajaria@broadinstitute.org"
    }

    runtime {
    	   docker: "tmajarian/wgsa_parser@sha256:21bf06ce19d87963dfbb34b4e43f7461a8cea5fa5af10f74012c67f57ec428c6"
		   disks: "local-disk ${disk} SSD"
		   memory: "${mem}G"
    }

    output {
    	Pair[String, File] anno_out = (chr,"${label}.tsv")
    }	

}

workflow wf {
	Map[String,File] these_chr_anno
	String this_label
	String these_cols
	String these_split

	Int? this_disk
	Int? this_mem

	Array[String] chrs = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]

	call getScript
	
	scatter(pair in these_chr_anno) {
		call parse {
				input: anno=pair.right, label="${this_label}_${pair.left}", chr=pair.left, desired_columns=these_cols, columns_to_split=these_split, script=getScript.script, disk=this_disk, mem=this_mem
		}
	}
}
