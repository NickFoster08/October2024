#!/bin/bash
#SBATCH --job-name=Mor_Bovis_Bioproject        # Job name
#SBATCH --partition=batch                      # Partition (queue) name
#SBATCH --ntasks=1                             # Run on a single CPU
#SBATCH --cpus-per-task=4                      # Number of cores per task
#SBATCH --mem=40gb                             # Job memory request
#SBATCH --time=02-00:00:00                     # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                   # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu            # Where to send mail

# Set output directory variable
OUTDIR="/home/nf26742/BovMor1/fastqs"

#Tells the program to make the outdir folder if it cant find it
if [ ! -d $OUTDIR ] 
then
    mkdir -p $OUTDIR
fi

#Load modules
module load Bactopia/3.1.0

#move to working directory
cd $OUTDIR

#create accessions file of file name document
bactopia prepare \
 --path /home/nf26742/BovMor1/fastqs --ont