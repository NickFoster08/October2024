#!/bin/bash
#SBATCH --job-name=spain_downlaod       # Job name
#SBATCH --partition=batch               # Partition (queue) name
#SBATCH --ntasks=1                      # Run on a single CPU
#SBATCH --cpus-per-task=2               # Number of cores per task
#SBATCH --mem=40gb                      # Job memory request
#SBATCH --time=00-01:00:00              # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL            # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu     # Where to send mail

OUTDIR="/home/nf26742/All_Seqs/Spain/BF_2015"

module load SRA-Toolkit/3.0.3-gompi-2022a  

# Ensure the output directory exists
mkdir -p $OUTDIR

# List of accessions
accessions=(
    SAMN26814539
    SAMN26814541
    SAMN26814542
    SAMN26814545
    SAMN26814546
    SAMN26814547
    SAMN26814548
    SAMN26814549
    SAMN26814551
    SAMN26814552
    SAMN26814553
    SAMN26814556
    SAMN26814557
    SAMN26814558
    SAMN26814559
    SAMN26814562
    SAMN26814564
    SAMN26814565
    SAMN26814566
    SAMN26814567
    SAMN26814568
    SAMN26814569
    SAMN26814570
    SAMN26814571
    SAMN26814572
    SAMN26814573
    SAMN26814574
    SAMN26814575
    SAMN26814579
    SAMN26814580
    SAMN26814581
    SAMN26814582
    SAMN26814584
    SAMN26814583
    SAMN26814585
    SAMN26814586
    SAMN26814587
    SAMN26814588
    SAMN26814589
    SAMN26814590
    SAMN26814591
    SAMN26814592
    SAMN26814593
    SAMN26814595
    SAMN26814596
    SAMN26814597
    SAMN26814598
    SAMN26814599
    SAMN26814600
    SAMN26814603
    SAMN26814604
    SAMN26814605
    SAMN26814606
    SAMN26814607
    SAMN26814608
    SAMN26814609
    SAMN26814610
    SAMN26814611
    SAMN26814613
    SAMN26814616
    SAMN26814617
    SAMN26814618
    SAMN26814619
    SAMN26814620
    SAMN26814621
    SAMN26814622
    SAMN26814623
    SAMN26814624
    SAMN26814625
    SAMN26814626
)

# Loop to download and convert SRA files
for accession in "${accessions[@]}"; do
    # Download the SRA file
    prefetch $accession
    # Convert to FASTQ format
    fasterq-dump $accession -O $OUTDIR
done
