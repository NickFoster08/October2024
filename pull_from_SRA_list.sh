#!/bin/bash
#SBATCH --job-name=tunisia_BF2015      # Job name
#SBATCH --partition=batch                # Partition (queue) name
#SBATCH --ntasks=1                       # Run on a single CPU
#SBATCH --cpus-per-task=8                # Number of cores per task
#SBATCH --mem=80gb                       # Job memory request
#SBATCH --time=00-12:00:00               # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL             # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu      # Where to send mail

# Specify output directory
OUTDIR="/home/nf26742/All_Seqs/Tunisia/BF_2015"

# Create output directory if it doesn't exist
mkdir -p "$OUTDIR"

# Load SRA tools
module load SRA-Toolkit/3.0.3-gompi-2022a

# List of accessions
accessions=(
)

# Loop to download and convert SRA files
for accession in "${accessions[@]}"; do
    echo "Processing accession: $accession"
    # Download the SRA file
    prefetch "$accession"
    if [[ $? -eq 0 ]]; then
        echo "Successfully downloaded $accession"
        # Convert to FASTQ format
        fasterq-dump "$accession" -O "$OUTDIR" --threads 8
        if [[ $? -eq 0 ]]; then
            echo "Successfully converted $accession to FASTQ"
        else
            echo "Error converting $accession to FASTQ"
        fi
    else
        echo "Error downloading $accession"
    fi
done
