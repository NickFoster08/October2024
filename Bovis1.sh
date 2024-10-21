#!/bin/bash
#SBATCH --job-name=Mor_Bovis_Bioproject        # Job name
#SBATCH --partition=batch             # Partition (queue) name
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --cpus-per-task=8             #number of cores per task
#SBATCH --mem=40gb                     # Job memory request
#SBATCH --time=02-00:00:00               # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out    # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err     # Standard error log

#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu  # Where to send mail (change username@uga.edu to your email address)

# Set output directory variable
OUTDIR="/home/nf26742/BovMor1/bactopia_output1/"
FASTQ_DIR="/home/nf26742/BovMor1/MbovisRawFASTQ"  # Directory for raw FASTQ files

# Create the output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

# Load modules
module load Bactopia/3.1.0

# Move to working directory
cd $OUTDIR

# Create datasets (if needed)
bactopia datasets --query $FASTQ_DIR

# Run Bactopia with local FASTQ files
bactopia \
    --fastqs $FASTQ_DIR \
    --coverage 100 \
    --outdir $OUTDIR/bactopia_MorBov_run \
    --max_cpus 8