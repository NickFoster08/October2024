#!/bin/bash
#SBATCH --job-name=vSNP_Step2_All       # Job name
#SBATCH --partition=batch                     # Partition (queue) name
#SBATCH --ntasks=1                            # Run on a single CPU
#SBATCH --cpus-per-task=8                     # Number of cores per task
#SBATCH --mem=40gb                            # Job memory request
#SBATCH --time=02-00:00:00                    # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                  # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu           # Where to send mail

# Set output directory variable
OUTDIR=/scratch/nf26742/ALLSeqsStep2

# Create the output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

# Reference genome file
REFERENCE="/home/nf26742/vsnp3_test_dataset/vsnp_dependencies/Mycobacterium_AF2122"

# Load vsnp module
module load vsnp3/3.26

# Navigate to the correct directory
cd /scratch/nf26742/VCF_Per_Country/all_VCF

# Start step 2 analysis
vsnp3_step2.py -a -t $REFERENCE 

