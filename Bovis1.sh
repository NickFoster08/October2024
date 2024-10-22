#!/bin/bash
#SBATCH --job-name=Mor_Bovis_Bioproject        # Job name
#SBATCH --partition=batch                       # Partition (queue) name
#SBATCH --ntasks=1                              # Run on a single CPU
#SBATCH --cpus-per-task=4                      # Number of cores per task
#SBATCH --mem=40gb                              # Job memory request
#SBATCH --time=02-00:00:00                      # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                    # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu             # Where to send mail

#set output directory variable
OUTDIR="/home/nf26742/BovMor1/bactopia_output1/bactopia_MorBov_run"

#Tells the program to make the ourdir folder if it cant find it
if [ ! -d $OUTDIR ] 
then
    mkdir -p $OUTDIR
fi

#load bactopia
module load Bactopia/3.1.0

#tell bactopia to prepare samnples and generate FOFN
bactopia prepare \
    --path /home/nf26742/BovMor1/MbovisRawFASTQ \
    --fastq-ext ".fastq" \
    --species "Mycobacterium bovis" \
    --genome-size 2800000 \
    --pe1-pattern "_R1_unaligned|_R1_001|_unmapped_R1|_R1" \
    --pe2-pattern "_R2_unaligned|_R2_001|_unmapped_R2|_R2" \
    --outdir /home/nf26742/BovMor1/Bov_FOFN


#move to working directory
cd $OUTDIR

#invoke bactopia
bactopia \
    --fastqs /home/nf26742/BovMor1/Bov_FOFN \
    --outdir $OUTDIR/ 
    --max_cpus 4

#prepare summary file
bactopia summary --bactopia-path $OUTDIR