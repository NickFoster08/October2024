#!/bin/bash
#SBATCH --job-name=spain_downlaod       # Job name
#SBATCH --partition=batch                       # Partition (queue) name
#SBATCH --ntasks=1                              # Run on a single CPU
#SBATCH --cpus-per-task=2                       # Number of cores per task
#SBATCH --mem=40gb                              # Job memory request
#SBATCH --time=00-01:00:00                      # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                    # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu             # Where to send mail

OUTDIR="/home/nf26742/All_Seqs/Spain/AF_2015"

module load SRA-Toolkit/3.0.3-gompi-2022a  

# List of accessions
accessions=(
    "SAMN26814673"
    "SAMN26814672"
    "SAMN26814671"
    "SAMN26814669"
    "SAMN26814668"
    "SAMN26814667"
    "SAMN26814666"
    "SAMN26814665"
    "SAMN26814664"
    "SAMN26814661"
    "SAMN26814659"
    "SAMN26814657"
    "SAMN26814656"
    "SAMN26814655"
    "SAMN26814654"
    "SAMN26814653"
    "SAMN26814652"
    "SAMN26814651"
    "SAMN26814650"
    "SAMN26814649"
)

# Loop to download and convert SRA files
for accession in "${accessions[@]}"; do
    # Download the SRA file
    prefetch $accession
    # Convert to FASTQ format
    fasterq-dump $accession -O /$OUTDIR
done
