#!/bin/bash
#SBATCH --job-name=Bovis_Project_snppy       # Job name
#SBATCH --partition=batch                        # Partition (queue) name
#SBATCH --ntasks=1                               # Run on a single CPU
#SBATCH --cpus-per-task=4                        # Number of cores per task
#SBATCH --mem=40gb                               # Job memory request
#SBATCH --time=02-00:00:00                       # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                     # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu              # Where to send mail

#set output directory variable
OUTDIR="/scratch/nf26742/BovMor1"

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
datasets download genome accession GCF_000195835.3 --include gbff
unzip ncbi_dataset.zip
