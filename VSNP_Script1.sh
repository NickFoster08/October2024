#!/bin/bash
#SBATCH --job-name=VSNP_mbovis_mor        # Job name
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
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

# Load vsnp module
module load vsnp3/3.26

# Navigate to the correct directory
cd /scratch/nf26742/BovMor1/fastqs

# Loop through R1 files using wildcard
for R1 in *_R1.fastq.gz; do
    # Generate the corresponding R2 file name by replacing _R1 with _R2
    R2="${R1/_R1/_R2}"
    
    # Check if the corresponding R2 file exists
    if [[ -f "$R2" ]]; then
        # Extract the sample name (e.g., 17-12281_S22_L001)
        SAMPLE_NAME=$(basename "$R1" "_R1.fastq.gz")
        
        # Create output directory for each sample
        SAMPLE_OUTDIR="$OUTDIR/$SAMPLE_NAME"
        if [ ! -d "$SAMPLE_OUTDIR" ]; then
            mkdir -p "$SAMPLE_OUTDIR"
        fi
        
        echo "Processing sample: $SAMPLE_NAME"
        
        # Run vsnp3_step1.py for the pair
        vsnp3_step1.py \
            -r1 "$R1" \
            -r2 "$R2" \
            -r /scratch/nf26742/BovMor1/fastqs/NC_002945v4.fasta \
            -o "$SAMPLE_OUTDIR"
    else
        echo "Warning: Missing R2 file for $R1, skipping..."
    fi
