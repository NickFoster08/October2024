#!/bin/bash
#SBATCH --job-name=Training                     # Job name
#SBATCH --partition=batch                        # Partition (queue) name
#SBATCH --ntasks=1                               # Run on a single CPU
#SBATCH --mem=1gb                                # Job memory request
#SBATCH --time=02:00:00                          # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                     # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yourMyID@uga.edu             # Where to send mail    

# Set output directory variable
OUTDIR="/scratch/nf26742/ref"

# Create output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

# Load modules
module load NCBI-Datasets-CLI/16.4.4

# Move to working directory
cd $OUTDIR

# Download datasets
datasets download genome accession GCF_000195955.2n
if [ $? -ne 0 ]; then
    echo "Error downloading datasets" >&2
    exit 1
fi

# Unzip datasets
unzip ncbi_dowload.zip
if [ $? -ne 0 ]; then
    echo "Error unzipping datasets" >&2
    exit 1
fi

# Cleanup
rm ncbi_dowload.zip
