#!/bin/bash
#SBATCH --job-name=vSNP_AllSeqs        # Job name
#SBATCH --partition=batch              # Partition (queue) name
#SBATCH --ntasks=1                     # Run on a single CPU
#SBATCH --cpus-per-task=8              # Number of cores per task
#SBATCH --mem=80gb                     # Job memory request
#SBATCH --time=02-00:00:00             # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL           # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu    # Where to send mail

set -euo pipefail  # Enable strict error handling

# Set output directory variable (unique for each job)
OUTDIR="/scratch/nf26742/AllSeqsAttempt2/job_${SLURM_JOB_ID}"
mkdir -p "$OUTDIR"

# Set reference variable
REFERENCE="/home/nf26742/vsnp3_test_dataset/vsnp_dependencies/Mycobacterium_AF2122"

# Load vsnp module
module load vsnp3/3.26

# Navigate to the correct directory
cd /home/nf26742/All_Seqs || { echo "Directory /home/nf26742/All_Seqs not found!" >&2; exit 1; }

# Find all R1 and R2 files recursively and process them
find /home/nf26742/All_Seqs -mindepth 2 -type f -name "*_1.fastq" | while read -r R1; do
    SAMPLE_ID=$(basename "$R1" | cut -d'_' -f1)
    R2="${R1%_1.fastq}_2.fastq"  # Construct the corresponding R2 filename

    # Run seqkit stats to determine read quality
    READ_COUNT=$(seqkit stats "$R1" | awk 'NR==2 {print $4}')
    AVG_LENGTH=$(seqkit stats "$R1" | awk 'NR==2 {print $6}')

    # Define thresholds for exclusion
    MIN_READ_COUNT=400000
    MIN_AVG_LENGTH=100

    if [[ "$READ_COUNT" -lt "$MIN_READ_COUNT" || "$AVG_LENGTH" -lt "$MIN_AVG_LENGTH" ]]; then
        echo "Skipping low-quality sample: $SAMPLE_ID (Reads: $READ_COUNT, Avg Length: $AVG_LENGTH)"
        continue
    fi

    # Ensure both R1 and R2 exist and are not empty
    if [[ -s "$R1" && -s "$R2" ]]; then
        echo "Processing: $R1 and $R2"

        # Ensure alignment directory doesn't already exist to prevent shutil.move error
        ALIGNMENT_DIR="$OUTDIR/alignment_NC_002945v4"
        if [ -d "$ALIGNMENT_DIR" ]; then
            echo "Removing existing alignment directory: $ALIGNMENT_DIR"
            rm -rf "$ALIGNMENT_DIR"
        fi

        # Ensure unmapped_reads directory doesn't already exist to prevent shutil.move error
        UNMAPPED_DIR="$OUTDIR/alignment_NC_002945v4/unmapped_reads"
        if [ -d "$UNMAPPED_DIR" ]; then
            echo "Removing existing directory: $UNMAPPED_DIR"
            rm -rf "$UNMAPPED_DIR"
        fi

        # Run vSNP and check if temp_fastq_seqkit_stats.txt is empty
        vsnp3_step1.py -r1 "$R1" -r2 "$R2" -t "$REFERENCE" -o "$OUTDIR" 2>> "$OUTDIR/vsnp_errors.log"

        # Verify that temp_fastq_seqkit_stats.txt is not empty
        STATS_FILE="$OUTDIR/temp_fastq_seqkit_stats.txt"
        if [[ ! -s "$STATS_FILE" ]]; then
            echo "Warning: $STATS_FILE is empty. Skipping sample." >&2
            continue
        fi
    else
        echo "Warning: $R1 or $R2 is missing or empty! Skipping..." >&2
    fi

done
