#!/bin/bash
#SBATCH --job-name=Bactopia_tutorial_multiple_local         # Job name
#SBATCH --partition=batch             # Partition (queue) name
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --cpus-per-task=8             #number of cores per task
#SBATCH --mem=40gb                     # Job memory request
#SBATCH --time=03:00:00               # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out    # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err     # Standard error log

#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu  # Where to send mail (change username@uga.edu to your email address)

#set output directory variable
OUTDIR="/scratch/nf26742/bactopia_tutorial"

#Tells the program to make the outdir folder if it cant find it

if [ ! -d $OUTDIR ] 
then
    mkdir -p $OUTDIR
fi

#load modules
module load Bactopia/3.1.0

#move to working directory
cd $OUTDIR

#Prepare file of file names
bactopia prepare \
    --path $OUTIDR/fastqs \
    --species"Staphylococcus aureus" \
    --genome-size 2800000 \
    > $OUTDIR/samples.txt