#!/bin/bash
#SBATCH --job-name=Mor_Bovis_Bioproject          # Job name
#SBATCH --partition=batch                        # Partition (queue) name
#SBATCH --ntasks=1                               # Run on a single CPU
#SBATCH --cpus-per-task=4                        # Number of cores per task
#SBATCH --mem=40gb                               # Job memory request
#SBATCH --time=02-00:00:00                       # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log
#SBATCH --mail-type=END,FAIL                     # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu              # Where to send mail

# Set output directory variable
OUTDIR=/home/nf26742/BovMor1/fastqs 

# Create the output directory if it doesn't exist
if [ ! -d "$OUTDIR" ]; then
    mkdir -p "$OUTDIR"
fi

# Load Bactopia module
module load Bactopia/3.1.0

# Tell Bactopia to prepare samples and generate FOFN
bactopia prepare \
    --path "$OUTDIR" \
    --fastq-ext ".fastq.gz" \
    --species "Mycobacterium bovis" \
    --genome-size 2800000 \
    --pe1-pattern "_R1_001" \
    --pe2-pattern "_R2_001"

# Check if the FOFN was generated successfully
FOFN="$OUTDIR/samples.fofn"
if [ ! -f "$FOFN" ]; then
    echo "Error: FOFN file not found: $FOFN"
    exit 1
fi

# Move to the output directory
cd "$OUTDIR" || exit

# Invoke Bactopia using the generated FOFN
bactopia \
    --fastqs "$FOFN" \
    --outdir "$OUTDIR" \
    --max_cpus 4

# Prepare summary file
bactopia summary --bactopia-path "$OUTDIR"
