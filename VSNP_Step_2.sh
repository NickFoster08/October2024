#!/bin/bash
#SBATCH --job-name=vSNP_Step2_mbovis       # Job name
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
OUTDIR=/scratch/nf26742/BovMor1/fastqs/VSNP_Step2_Output

# Create the output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

# Load vsnp module
module load vsnp3/3.26

# Navigate to the correct directory
cd /scratch/nf26742/BovMor1/fastqs

# Reference genome file
REFERENCE="/home/nf26742/vsnp3_test_dataset/vsnp_dependencies/Mycobacterium_AF2122"

#Start step 2 analysis
cd /scratch/nf26742/BovMor1/fastqs/zc.vcf_Step1_Output
vsnp3_step2.py -a -t $REFERENCE
