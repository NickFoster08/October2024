#!/bin/bash
#SBATCH --job-name=BEDTOOLS_SNP_Name      # Job name
#SBATCH --partition=batch                 # Partition (queue) name
#SBATCH --ntasks=1                         # Run on a single CPU
#SBATCH --cpus-per-task=8                  # Number of cores per task
#SBATCH --mem=40gb                         # Job memory request
#SBATCH --time=02-00:00:00                 # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL               # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu        # Where to send mail

# Set output directory variable
OUTDIR=/scratch/nf26742/BovMor1/fastqs/Annotations

# Create the output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

# Check if input files exist
if [ ! -f /lustre2/scratch/nf26742/BovMor1/fastqs/positions.bed ]; then
    echo "positions.bed not found!"
    exit 1
fi

if [ ! -f /lustre2/scratch/nf26742/BovMor1/fastqs/sequence.gff3 ]; then
    echo "sequence.gff3 not found!"
    exit 1
fi

# Load bedtools
module load BEDTools/2.31.0-GCC-12.3.0

# Check if BEDTools module is loaded
module list 2>&1 | grep -q "BEDTools"
if [ $? -ne 0 ]; then
    echo "BEDTools module not loaded!"
    exit 1
fi

# Define output file with job ID to avoid overwriting
OUTPUT_FILE=/scratch/nf26742/BovMor1/fastqs/annotated_positions_${SLURM_JOB_ID}.bed

# Run bedtools intersect
echo "Running bedtools intersect"
echo "Input files: /lustre2/scratch/nf26742/BovMor1/fastqs/positions.bed and /lustre2/scratch/nf26742/BovMor1/fastqs/sequence.gff3"
echo "Output file: $OUTPUT_FILE"

bedtools intersect -a /lustre2/scratch/nf26742/BovMor1/fastqs/positions.bed -b /lustre2/scratch/nf26742/BovMor1/fastqs/sequence.gff3 -wa -wb > $OUTPUT_FILE
