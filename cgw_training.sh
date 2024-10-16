#!/bin/bash
#SBATCH --job-name=NCBI        # Job name
#SBATCH --partition=batch             # Partition (queue) name
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=1gb                     # Job memory request
#SBATCH --time=02:00:00               # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out            # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err             # Standard error log

#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu  # Where to send mail	

#set output directory variable
OUTDIR="/scratch/nf26742/ref"

#Tells the program to make the ourdir folder if it cant find it
if [ ! -d $OUTDIR ] 
then
    mkdir -p $OUTDIR
fi

#Load modules
module load NCBI-Datasets-CLI/16.4.4

#move to working directory
cd $OUTDIR

#download datasets and unzip
datasets download genome accession GCF_000195955.2 --include cds,genome
unzip ncbi_download.zip
#test
#test2
