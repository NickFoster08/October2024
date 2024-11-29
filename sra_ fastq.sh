#!/bin/bash
#SBATCH --job-name=SRA-FASTQ_Spain        # Job name
#SBATCH --partition=batch                      # Partition (queue) name
#SBATCH --ntasks=1                             # Run on a single CPU
#SBATCH --cpus-per-task=2                      # Number of cores per task
#SBATCH --mem=10gb                             # Job memory request
#SBATCH --time=00-01:00:00                     # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                   # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu            # Where to send mail

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
