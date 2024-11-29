#!/bin/bash

# Load the SRA Toolkit module
module load SRA-Toolkit/3.0.3-gompi-2022a

# Define the output directory where the FASTQ files will be stored
output_dir="/home/nf26742/All_Seqs/Spain/AF_2015/fastqs"

# Loop over each SRR directory and convert the corresponding .sra file to FASTQ
for sra_dir in SRR*; do
    # Check if the directory contains a .sra file
    if [ -f "$sra_dir/$sra_dir.sra" ]; then
        echo "Processing $sra_dir/$sra_dir.sra..."
        
        # Run fasterq-dump to convert to FASTQ format
        fasterq-dump $sra_dir/$sra_dir.sra --outdir $output_dir
        
        echo "$sra_dir processed successfully."
    else
        echo "No .sra file found in $sra_dir."
    fi
done
