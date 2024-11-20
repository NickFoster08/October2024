#!/bin/bash
#SBATCH --job-name=vSNP_Optimized_No_LOOP        # Job name
#SBATCH --partition=batch                 # Partition (queue) name
#SBATCH --ntasks=1                        # Run on a single CPU
#SBATCH --cpus-per-task=8                 # Number of cores per task
#SBATCH --mem=40gb                        # Job memory request
#SBATCH --time=02-00:00:00                # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL              # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu       # Where to send mail

# Set output directory variable
OUTDIR=/scratch/nf26742/BovMor1/fastqs/VSNP_Output

# Create the output directory if it doesn't exist
if [ ! -d "$OUTDIR" ]; then
    echo "Creating VSNP output directory: $OUTDIR"
    mkdir -p "$OUTDIR" || { echo "Failed to create $OUTDIR"; exit 1; }
fi

# Set reference variable
REFERENCE="/home/nf26742/vsnp3_test_dataset/vsnp_dependencies/Mycobacterium_AF2122"

# Load vsnp module
module load vsnp3/3.26 || { echo "Failed to load vsnp3 module"; exit 1; }

# Navigate to the correct directory
cd /scratch/nf26742/BovMor1/fastqs || { echo "Directory not found: /scratch/nf26742/BovMor1/fastqs"; exit 1; }

# Run vsnp3_step1.py for each pair of R1 and R2 files
vsnp3_step1.py \
    -r1 *_R1.fastq.gz \
    -r2 *_R2.fastq.gz \
    -t "$REFERENCE" \
    -o "$OUTDIR" || { echo "vSNP step1 failed"; exit 1; }
