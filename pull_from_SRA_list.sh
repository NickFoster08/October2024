#!/bin/bash
#SBATCH --job-name=algeria_AF2015      # Job name
#SBATCH --partition=batch                # Partition (queue) name
#SBATCH --ntasks=1                       # Run on a single CPU
#SBATCH --cpus-per-task=8                # Number of cores per task
#SBATCH --mem=80gb                       # Job memory request
#SBATCH --time=00-12:00:00               # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL             # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu      # Where to send mail

# Specify output directory
OUTDIR="/home/nf26742/All_Seqs/Algeria/AF_2015"

# Create output directory if it doesn't exist
mkdir -p "$OUTDIR"

# Load SRA tools
module load SRA-Toolkit/3.0.3-gompi-2022a

# List of accessions
accessions=(
SAMEA6617092
SAMEA6617091
SAMEA6617080
SAMEA6617081
SAMEA6617082
SAMEA6617083
SAMEA6617084
SAMEA6617085
SAMEA6617086
SAMEA6617087
SAMEA6617089
SAMEA6617088
SAMEA6617090
SRR13986556
SRR13986557
SRR13986558
SRR13986559
SRR13986560
SRR13986561
SRR13986562
SRR13986563
SRR13986564
SRR13986565
SRR13986566
SRR13986567
SRR13986568
)

# Loop to download and convert SRA files
for accession in "${accessions[@]}"; do
    echo "Processing accession: $accession"
    # Download the SRA file
    prefetch "$accession"
    if [[ $? -eq 0 ]]; then
        echo "Successfully downloaded $accession"
        # Convert to FASTQ format
        fasterq-dump "$accession" -O "$OUTDIR" --threads 8
        if [[ $? -eq 0 ]]; then
            echo "Successfully converted $accession to FASTQ"
        else
            echo "Error converting $accession to FASTQ"
        fi
    else
        echo "Error downloading $accession"
    fi
done
