#!/bin/bash
#SBATCH --job-name=BEAST_mbovis_mor        # Job name
#SBATCH --partition=batch                  # Partition (queue) name
#SBATCH --ntasks=1                         # Run on a single CPU
#SBATCH --cpus-per-task=8                  # Number of cores per task
#SBATCH --mem=40gb                         # Job memory request
#SBATCH --time=07-00:00:00                 # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL               # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu        # Where to send mail

# Load BEAST module
module load Beast/2.7.7-GCC-11.3.0 

# Define the output directory
outdir="/scratch/nf26742/scratch/beast_output"

# Create the output directory if it doesn't exist
mkdir -p $outdir

# Run BEAST with 8 threads
beast -threads 8 /lustre2/scratch/nf26742/BovMor1/fastqs/bactopia-runs/snippy-20241025-125933/core-snp-with-end-cap.xml
