#!/bin/bash
#SBATCH --job-name=spain_downlaod       # Job name
#SBATCH --partition=batch                       # Partition (queue) name
#SBATCH --ntasks=1                              # Run on a single CPU
#SBATCH --cpus-per-task=8                       # Number of cores per task
#SBATCH --mem=80gb                              # Job memory request
#SBATCH --time=00-012:00:00                      # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                    # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu             # Where to send mail

#specify outdir
OUTDIR="/home/nf26742/All_Seqs/Portugal/AF_2015"

#load SRA tools
module load SRA-Toolkit/3.0.3-gompi-2022a

# List of accessions
accessions=(
SAMN33843519
SAMN33843536
SAMN33843537
SAMN33843539
SAMN33843555
SAMN33843557
SAMN33843570
SAMN33843572
SAMN33849789
SAMN33871440
SAMN33871459
)

# Loop to download and convert SRA files
for accession in "${accessions[@]}"; do
    # Download the SRA file
    prefetch $accession
    # Convert to FASTQ format
    fasterq-dump $accession -O /$OUTDIR
done
