#!/bin/bash
#SBATCH --job-name=BEAST_mbovis_mor        # Job name
#SBATCH --partition=batch                        # Partition (queue) name
#SBATCH --ntasks=1                               # Run on a single CPU
#SBATCH --cpus-per-task=4                        # Number of cores per task
#SBATCH --mem=40gb                               # Job memory request
#SBATCH --time=02-00:00:00                       # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                     # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu              # Where to send mail

# Set output directory variable
OUTDIR="/scratch/nf26742/BovMor1/fastqs"

#load module
module load beast/2.6.3

#run beast
beast -threads 4 /lustre2/scratch/nf26742/BovMor1/Bovisanalysis.xml