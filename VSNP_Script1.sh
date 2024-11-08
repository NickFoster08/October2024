#!/bin/bash
#SBATCH --job-name=vSNP_mbovis_mor        # Job name
#SBATCH --partition=batch                  # Partition (queue) name
#SBATCH --ntasks=1                         # Run on a single CPU
#SBATCH --cpus-per-task=8                  # Number of cores per task
#SBATCH --mem=40gb                         # Job memory request
#SBATCH --time=02-00:00:00                 # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL               # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu        # Where to send mail

# Activate conda environment and run the script
module load conda
conda activate vsnp3

# Run vsnp3 with your FASTQ files
python ~/.conda/envs/vsnp3/bin/vsnp3_step1.py -r1 /scratch/nf26742/BovMor1/fastqs/*_R1.fastq.gz -r2 /scratch/nf26742/BovMor1/fastqs/*_R2.fastq.gz -t Mycobacterium_AF2122
