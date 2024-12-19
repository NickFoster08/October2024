#!/bin/bash
#SBATCH --job-name=portugal_downlaod       # Job name
#SBATCH --partition=batch               # Partition (queue) name
#SBATCH --ntasks=1                      # Run on a single CPU
#SBATCH --cpus-per-task=2               # Number of cores per task
#SBATCH --mem=40gb                      # Job memory request
#SBATCH --time=00-03:00:00              # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL            # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu     # Where to send mail

OUTDIR="/home/nf26742/All_Seqs/Portugal/BF_2015"

module load SRA-Toolkit/3.0.3-gompi-2022a  

# Ensure the output directory exists
mkdir -p $OUTDIR

# List of accessions
accessions=(
SAMN33843519
SAMN33843513
SAMN33843487
SAMN33843486
SAMN33843481
SAMN33843468
SAMN33843467
SAMN33843466
SAMN33843461
SAMN33843460
SAMN33843459
SAMN33843455
SAMN33843447
SAMN33843446
SAMN33843445
SAMN33843443
SAMN33843442
SAMN33843441
SAMN33843440
SAMN17004175
SAMN17004173
SAMN17004170
SAMN17004165
SAMN17004164
SAMN17004161
SAMN17004158
SAMN17004154
SAMN17004153
SAMN17004151
SAMN17004150
SAMN17004147
SAMN17004145
SAMN17004144
SAMN17004143
SAMN17004141
)

# Loop to download and convert SRA files
for accession in "${accessions[@]}"; do
    # Download the SRA file
    prefetch $accession
    # Convert to FASTQ format
    fasterq-dump $accession -O $OUTDIR
done
