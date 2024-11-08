#!/bin/bash
#SBATCH --job-name=VSNP_mbovis_mor        # Job name
#SBATCH --partition=batch                  # Partition (queue) name
#SBATCH --ntasks=1                         # Run on a single CPU
#SBATCH --cpus-per-task=8                  # Number of cores per task
#SBATCH --mem=40gb                         # Job memory request
#SBATCH --time=02-00:00:00                 # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL               # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu        # Where to send mail

# Load the required Conda module (if not automatically loaded)
module load conda

# Activate the vSNP3 environment
source ~/anaconda3/etc/profile.d/conda.sh
conda activate vsnp3

# Set paths for your FASTQ files and reference
FASTQ_DIR="/scratch/nf26742/BovMor1/fastqs"
OUTPUT_DIR="/scratch/nf26742/vsnp3_output"
REFERENCE_DIR="~/vsnp3_test_dataset/vsnp_dependencies"

# Add the reference to the environment
vsnp3_path_adder.py -d $REFERENCE_DIR

# Step 1: Alignment and SNP calling
cd $FASTQ_DIR

# Run vSNP3 Step 1
vsnp3_step1.py -r1 ${FASTQ_DIR}/*_R1*.fastq.gz -r2 ${FASTQ_DIR}/*_R2*.fastq.gz -t Mycobacterium_AF2122 -o $OUTPUT_DIR

# Step 2: SNP matrix and phylogenetic tree generation
cd $OUTPUT_DIR/step2

# Run vSNP3 Step 2 using the Zero Coverage VCF files from Step 1
vsnp3_step2.py -a -t Mycobacterium_AF2122 -o $OUTPUT_DIR

# Deactivate Conda environment
conda deactivate

