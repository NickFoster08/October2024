#!/bin/bash
#SBATCH --job-name=VSNP_Algeria        # Job name
#SBATCH --partition=batch              # Partition (queue) name
#SBATCH --ntasks=1                     # Run on a single CPU
#SBATCH --cpus-per-task=8              # Number of cores per task
#SBATCH --mem=40gb                     # Job memory request
#SBATCH --time=02-00:00:00             # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL           # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu    # Where to send mail

set -euo pipefail  # Enable strict error handling

# Define output directory for step 1 results
OUTDIR="/scratch/nf26742/AllSeqsAttempt3/job_${SLURM_JOB_ID}"

# Remove the directory first to avoid conflicts, then recreate it
if [ -d "$OUTDIR" ]; then
    echo "Removing pre-existing output directory: $OUTDIR"
    rm -rf "$OUTDIR"
fi
mkdir -p "$OUTDIR"

# Set reference genome variable
REFERENCE="/home/nf26742/vsnp3_test_dataset/vsnp_dependencies/Mycobacterium_AF2122/NC_002945v4.fasta"

# Load vsnp module
module load vsnp3/3.26 || { echo "Error: Failed to load vsnp3 module"; exit 1; }

# Navigate to the correct directory
SEQ_DIR="/home/nf26742/All_Seqs/Algeria/AF_2015"
if [ ! -d "$SEQ_DIR" ]; then
    echo "Error: Directory $SEQ_DIR not found!"
    exit 1
fi
cd "$SEQ_DIR"

# Loop over each pair of R1 and R2 files
for r1_file in *_1.fastq; do
    # Generate the corresponding R2 file
    r2_file="${r1_file/_1.fastq/_2.fastq}"
    
    # Check if R2 file exists
    if [[ -f "$r2_file" && -s "$r1_file" && -s "$r2_file" ]]; then
        echo "Processing: $r1_file and $r2_file"

        # Ensure alignment directory doesn't already exist to prevent shutil.move error
        ALIGNMENT_DIR="$OUTDIR/alignment_NC_002945v4"
        if [ -d "$ALIGNMENT_DIR" ]; then
            echo "Removing existing alignment directory: $ALIGNMENT_DIR"
            rm -rf "$ALIGNMENT_DIR"
        fi

        # Run vsnp3_step1.py for each pair of R1 and R2 files
        vsnp3_step1.py -r1 "$r1_file" -r2 "$r2_file" -t "$REFERENCE" -o "$OUTDIR" 2>> "$OUTDIR/vsnp_errors.log"
        
        # Check if vSNP output is generated
        if [ ! -s "$OUTDIR/alignment_NC_002945v4/${r1_file%%_1.fastq}_zc.vcf" ]; then
            echo "Warning: No vSNP output for $r1_file and $r2_file"
        fi
    else
        echo "Warning: Missing or empty files for $r1_file, skipping..."
    fi
done
