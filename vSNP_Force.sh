#!/bin/bash
#SBATCH --job-name=vSNP_Force       # Job name
#SBATCH --partition=batch                 # Partition (queue) name
#SBATCH --ntasks=1                        # Run on a single CPU
#SBATCH --cpus-per-task=8                 # Number of cores per task
#SBATCH --mem=40gb                        # Job memory request
#SBATCH --time=02-00:00:00                # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL              # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu       # Where to send mail

# Set output directory variable
OUTDIR=/scratch/nf26742/BovMor1/fastqs/VSNP_Output

# Create the output directory if it doesn't exist
mkdir -p "$OUTDIR"

# Set reference variable 
REFERENCE="/home/nf26742/vsnp3_test_dataset/vsnp_dependencies/Mycobacterium_AF2122"

# Load vsnp module
module load vsnp3/3.26

# Navigate to the correct directory
cd /scratch/nf26742/BovMor1/fastqs

# Loop through all R1 fastq.gz files and match with corresponding R2 files
for r1_file in *_R1.fastq.gz; do
    # Generate corresponding R2 file
    r2_file="${r1_file/_R1/_R2}"

    # Run vsnp3_step1.py for each pair of R1 and R2 files
    if [ -f "$r2_file" ]; then
        echo "Processing: $r1_file and $r2_file"
        vsnp3_step1.py \
            -r1 "$r1_file" \
            -r2 "$r2_file" \
            -t "$REFERENCE" \
            -o "$OUTDIR"
    else
        echo "No matching R2 file found for $r1_file, skipping."
    fi
done
