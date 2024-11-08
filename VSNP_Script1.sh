#!/bin/bash
#SBATCH --job-name=VSNP_mbovis_mor        # Job name
#SBATCH --partition=batch                  # Partition (queue) name
#SBATCH --ntasks=1                         # Run on a single CPU
#SBATCH --cpus-per-task=8                  # Number of cores per task
#SBATCH --mem=40gb                         # Job memory request
#SBATCH --time=02-00:00:00                 # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL               # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu        # Where to send mail

# Load vsnp module (if needed)
module load vsnp

# Navigate to the directory with FASTQ files
cd /scratch/nf26742/BovMor1/fastqs

# Run vsnp3_step1.py with the appropriate file patterns
vsnp3_step1.py -r1 *_R1*.fastq.gz -r2 *_R2*.fastq.gz -t Mycobacterium_AF2122

# Run vsnp3_step2.py
vsnp3_step2.py -a -t Mycobacterium_AF2122
