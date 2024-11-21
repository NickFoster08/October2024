#!/bin/bash
#SBATCH --job-name=Bovis_Project_conversion     # Job name
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
OUTDIR=/scratch/nf26742/BovMor1/fastqs/Ref_Mbov/GCF_000195835.3_ASM19583v2_genomic.gbff.gz
SCRIPT=/home/nf26742/October2024

#load modules
module load Biopython/1.84-foss-2023b

#move to working directory
cd $OUTDIR

python $SCRIPT/conversion_gbf_gbk.py $OUTDIR/genomic.gbff $OUTDIR/genomic.gbk