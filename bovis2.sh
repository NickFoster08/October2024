#!/bin/bash
#SBATCH --job-name=Bovis_Project_Morrocco        # Job name
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
OUTDIR="/scratch/nf26742/BovMor1/fastqs" 
###Nick I recommend moving your fastqs to scratch due to the 200GB memory limit in home.
### You will create a ton of data running this pipeline and use up your 200GB quickly. 

# Create the output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
   mkdir -p $OUTDIR
fi

# Load Bactopia
module load Bactopia/3.1.0

# Move to the output directory
cd $OUTDIR

# Tell Bactopia to prepare samples and generate FOFN named mbovis_samples.txt
bactopia prepare \
    --path /scratch/nf26742/BovMor1/fastqs \
    --fastq-ext 'R1_001.fastq.gz' 'R2_001.fastq.gz' \
    --species "Mycobacterium bovis" \
    --genome-size 4400000 \
    > mbovis_sample.txt

# Invoke Bactopia using the generated FOFN
bactopia \
   --samples $OUTDIR/mbovis_samples.txt \
   --coverage 100 \
   --max_cpus 4 \
   --outdir $OUTDIR/scratch/nf26742/BovMor1/fastqs

# Prepare summary file
bactopia summary \
   --bactopia-path $OUTDIR/scratch/nf26742/BovMor1/fastqs