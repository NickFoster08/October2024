#!/bin/bash
#SBATCH --job-name=VSNP_mbovis_ReDO        # Job name
#SBATCH --partition=batch                  # Partition (queue) name
#SBATCH --ntasks=1                         # Run on a single CPU
#SBATCH --cpus-per-task=8                  # Number of cores per task
#SBATCH --mem=40gb                         # Job memory request
#SBATCH --time=02-00:00:00                 # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL               # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu        # Where to send mail

# Set output directory variable
OUTDIR="/scratch/nf26742/BovMor1/fastqs/VSNP_Output"

# Create the output directory if it doesn't exist
if [ ! -d "$OUTDIR" ]; then
    mkdir -p "$OUTDIR"
fi

# Load vsnp module
module load vsnp3/3.26

# Navigate to the correct directory
cd "/scratch/nf26742/BovMor1/fastqs" || { echo "Error: Directory not found"; exit 1; }

# Reference genome file
REFERENCE="/scratch/nf26742/BovMor1/fastqs/Ref_Mbov/GCF_000195835.3_ASM19583v2_genomic.gbff.gz"

# Loop through all R1 fastq files and find their corresponding R2
for R1 in *_R1.fastq.gz; do
    SAMPLE=$(basename "$R1" _R1.fastq.gz)
    R2="${SAMPLE}_R2.fastq.gz"

    # Check if the corresponding R2 file exists and is not empty
    if [ -f "$R2" ] && [ -s "$R2" ]; then
        echo "Processing sample: $SAMPLE"
        
        vsnp3_step1.py \
            -r1 "$R1" \
            -r2 "$R2" \
            -t "$REFERENCE" \
            -o "$OUTDIR"

    else
        echo "Warning: Missing or empty R2 for sample $SAMPLE, skipping..."
    fi
done

# Optional: Indicate successful completion
echo "Job completed successfully" >> "$OUTDIR/job_status.txt"
