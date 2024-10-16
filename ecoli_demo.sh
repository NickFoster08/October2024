#!/bin/bash
#SBATCH --job-name=Ecoli_Test         # Job name
#SBATCH --partition=batch             # Partition (queue) name
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=1gb                     # Job memory request
#SBATCH --time=02:00:00               # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out    # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err     # Standard error log

#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu  # Where to send mail (change username@uga.edu to your email address)

#set output variable
OUTDIR="/scratch/nf26742/ref"
#set variable URL for genome website
URL=https://ftp.ensemblgenomes.ebi.ac.uk/pub/bacteria/release-59/gff3/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655_gca_000005845/Escherichia_coli_str_k_12_substr_mg1655_gca_000005845.ASM584v2.59.gff3.gz

#Tells the program to make the ourdir folder if it cant find it
if [ ! -d $OUTDIR ] 
then
    mkdir -p $OUTDIR
fi

###Grab annotated genome file from the URL variable and then unzip it and put it in a file called ecoli_MG1655.gff
curl -s $URL | gunzip -c > $OUTDIR/ecoli_MG1655.gff
#count number of CDS features
grep -c "CDS" $OUTDIR/ecoli_MG1655.gff > $OUTDIR/results.txt
