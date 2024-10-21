#!/bin/bash
#SBATCH --job-name=Mor_Bovis_Bioproject        # Job name
#SBATCH --partition=batch                       # Partition (queue) name
#SBATCH --ntasks=1                              # Run on a single CPU
#SBATCH --cpus-per-task=8                       # Number of cores per task
#SBATCH --mem=40gb                              # Job memory request
#SBATCH --time=02-00:00:00                      # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                    # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu             # Where to send mail

# Set output directory variable
OUTDIR="/home/nf26742/BovMor1/bactopia_output1/"
FASTQ_DIR="/home/nf26742/BovMor1/MbovisRawFASTQ"  # Directory for raw FASTQ files
SAMPLE_LIST="$OUTDIR/samples.txt"  # File to store sample list

# Create the output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

# Load modules
module load Bactopia/3.1.0

# Move to FASTQ directory
cd $FASTQ_DIR

# Prepare FOFNs and generate the sample list
# Prepare FOFNs and generate the sample list
bactopia prepare \
    --path $OUTDIR/fastqs \
    --fastq-ext "fastq" \
    --species "Mycobacterium bovis" \
    --genome-size 2800000 \
    --pe1-pattern "_R1_unaligned|_R1|_R1_001|_unmapped_R1" \
    --pe2-pattern "_R2_unaligned|_R2|_R2_001|_unmapped_R2" \
    > $OUTDIR/samples.txt

# Move to output directory 
cd $OUTDIR

# Check if the sample list was created
if [ -f "$SAMPLE_LIST" ]; then
    # Run Bactopia with the sample list
    bactopia \
        --samples $OUTDIR/samples.txt \
        --coverage 100 \
        --outdir $OUTDIR/bactopia_MorBov_run \
        --max_cpus 8
else
    echo "Error: $OUTDIR/samples.txt not found. Please check the prepare step."
    exit 1
fi
