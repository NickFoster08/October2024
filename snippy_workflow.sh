#!/bin/bash
#SBATCH --job-name=snippy_mbovis_mor        # Job name
#SBATCH --partition=batch                        # Partition (queue) name
#SBATCH --ntasks=1                               # Run on a single CPU
#SBATCH --cpus-per-task=4                        # Number of cores per task
#SBATCH --mem=40gb                               # Job memory request
#SBATCH --time=02-00:00:00                       # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                     # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu              # Where to send mail

# Set output directory variable
OUTDIR="/scratch/nf26742/BovMor1/fastqs"
REF="/scratch/nf26742/BovMor1/ncbi_dataset/data/GCF_000195835.3/genomic.gbk"

# Create the output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
   mkdir -p $OUTDIR
fi

# Load Bactopia
module load Bactopia/3.1.0

#snippy on bactopia workflow
#bactopia tools. Snippy and Gubbins are together in the snippy workflow
bactopia \
    --wf snippy\
    --refrence $REF\
    --exclude $OUTDIR/bactopia-exclude.tsv \
    --bactopia $OUTDIR