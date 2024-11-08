#!/bin/bash
#SBATCH --job-name=VSNP_mbovis_mor        # Job name
#SBATCH --partition=batch                 # Partition (queue) name
#SBATCH --ntasks=1                        # Run on a single CPU
#SBATCH --cpus-per-task=8                 # Number of cores per task
#SBATCH --mem=40gb                        # Job memory request
#SBATCH --time=2-00:00:00                 # Time limit (days-hours:min:sec)
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL              # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu       # Where to send mail

# Define output directory
OUTDIR="/home/nf26742/vsnpBovisWorkflow"

# Navigate to working directory with fastqs
cd /scratch/nf26742/BovMor1/fastqs

# Run vSNP command with the correct FASTQ files
vsnp3_step1.py -r1 17-12280_S21_L001_R1.fastq.gz -r2 17-12280_S21_L001_R2.fastq.gz -o $OUTDIR
