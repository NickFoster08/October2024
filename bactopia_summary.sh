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
#set output directory variable

OUTDIR="/scratch/nf26742/PRJNA1056148_bactopia"

#tells program to make outdir if it cant find it
#Tells the program to make the ourdir folder if it cant find it
if [ ! -d $OUTDIR ] 
then
    mkdir -p $OUTDIR
fi

#load modules
module load Bactopia/3.0.1

#move to working directory
cd $OUTDIR

#create summary files from bactopia pipeline on Ethiopian samples
bactopia summary --bactopia-path $OUTDIR/ena-multiple-samples/