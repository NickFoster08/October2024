#!/bin/bash
#SBATCH --job-name=vSNP_AllSeqs        # Job name
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
OUTDIR=/scratch/nf26742/AllSeqsAttempt1

# Create the output directory if it doesn't exist
if [ ! -d "$OUTDIR" ]; then
    echo "Creating VSNP output directory: $OUTDIR"
    mkdir -p "$OUTDIR"
fi

# Set reference variable 
REFERENCE="/home/nf26742/vsnp3_test_dataset/vsnp_dependencies/Mycobacterium_AF2122"

# Load vsnp module
module load vsnp3/3.26

# Navigate to the correct directory
cd /home/nf26742/All_Seqs

# Find all R1 and R2 files recursively and group them by sample
find /home/nf26742/All_Seqs -type f -name "*_1.fastq" | while read R1; do
    R2="${R1%_1.fastq}_2.fastq"  # Construct the corresponding R2 filename
    
    if [ -f "$R2" ]; then  # Ensure R2 exists
        echo "Processing: $R1 and $R2"
        vsnp3_step1.py -r1 "$R1" -r2 "$R2" -t "$REFERENCE" -o "$OUTDIR"
    else
        echo "Warning: Matching R2 file for $R1 not found!" >&2
    fi
done

