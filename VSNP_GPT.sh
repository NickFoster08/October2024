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

# Load vsnp module
module load vsnp3/3.26

# Navigate to the correct directory
cd /scratch/nf26742/BovMor1/fastqs

# Loop through each R1 and R2 pair
for r1 in *_R1.fastq.gz; do
    # Define corresponding R2 file
    r2="${r1/_R1/_R2}"
    
    # Run vsnp3_step1.py with each file pair
    vsnp3_step1.py -r1 "$r1" -r2 "$r2" -t Mycobacterium_AF2122
done