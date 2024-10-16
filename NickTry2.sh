#!/bin/bash
#SBATCH --job-name=NCBI        # Job name
#SBATCH --partition=batch       # Partition (queue) name
#SBATCH --ntasks=1              # Run on a single CPU
#SBATCH --mem=1gb               # Job memory request
#SBATCH --time=02:00:00         # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out            # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err             # Standard error log

#SBATCH --mail-type=END,FAIL    # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu  # Where to send mail

# Set output directory variable
OUTDIR="/scratch/nf26742/ref"

# Create the output directory if it doesn't exist
if [ ! -d "$OUTDIR" ]; then
    mkdir -p "$OUTDIR"
fi

# Load modules
module load NCBI-Datasets-CLI/16.4.4

# Move to working directory
cd "$OUTDIR"

# Download datasets
datasets download genome accession GCF_000195955.2 --include cds,genome

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Dataset download failed. Exiting."
    exit 1
fi

# Check if the zip file exists and unzip
if [ -f ncbi_download.zip ]; then
    unzip ncbi_download.zip
else
    echo "ncbi_download.zip not found. Exiting."
    exit 1
fi
