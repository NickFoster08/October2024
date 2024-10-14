#!/bin/bash
#SBATCH --job-name=Training         # Job name
#SBATCH --partition=batch             # Partition (queue) name
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=1gb                     # Job memory request
#SBATCH --time=02:00:00               # Time limit hrs:min:sec
#SBATCH --output=%x.%j.out            # Standard output log
#SBATCH --error=%x.%j.err             # Standard error log

#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yourMyID@uga.edu  # Where to send mail	

#set output directory varibale
OUTDIR= "/scratch/nf26742/ref"

#Tells the program to make the outdir file if it cant find it 
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi 
#Load modules
module load NCBI-Datasets-CLI/16.4.4

#Mover to working directory
cd $OUTDIR

#Download datasets and unzip
datasets download genome accession GCF_000195955.2 --include cds,genome
# Check if the zip file exists before unzipping
if [ -f ncbi_dataset.zip ]; then
    unzip ncbi_dataset.zip
else
    echo "Error: ncbi_dataset.zip not found."
fi
unzip ncbi_dataset.zip
# demonstration
