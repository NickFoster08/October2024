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

# Set the path to the directory containing your FASTQ files
cd /scratch/nf26742/BovMor1/fastq  # Adjust this path to your FASTQ folder

# Step 1: Run the first part of the VSNP process (ensure your files match the pattern)
vsnp3_step1.py -r1 *_R1*.fastq.gz -r2 *_R2*.fastq.gz -t Mycobacterium_bovis

# Step 2: Run the second part of the VSNP process (adjust to your needs)
cd /scratch/nf26742/BovMor1/fastq  # Adjust to where you want step2 outputs
vsnp3_step2.py -a -t Mycobacterium_bovis
