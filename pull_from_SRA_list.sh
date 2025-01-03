#!/bin/bash
#SBATCH --job-name=ptgal_download       # Job name
#SBATCH --partition=batch              # Partition (queue) name
#SBATCH --ntasks=1                     # Run on a single CPU
#SBATCH --cpus-per-task=8              # Number of cores per task
#SBATCH --mem=80gb                     # Job memory request
#SBATCH --time=00-12:00:00             # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL           # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu    # Where to send mail

# Specify output directory
OUTDIR="/home/nf26742/All_Seqs/Portugal/BF_2015"

# Load SRA tools
module load SRA-Toolkit/3.0.3-gompi-2022a

# Ensure output directory exists
mkdir -p "$OUTDIR"

# List of accessions
accessions=(
SAMN33843487
SAMN33843486
SAMN33843481
SAMN33843468
SAMN33843467
)
# Loop to download and convert SRA files
for accession in "${accessions[@]}"; do
    # Download the SRA file
    prefetch "$accession"
    # Convert to FASTQ format
    fasterq-dump "$accession" -O "$OUTDIR"
done
