#!/bin/bash
#SBATCH --job-name=vsnp3_analysis
#SBATCH --output=vsnp3_analysis.out
#SBATCH --error=vsnp3_analysis.err
#SBATCH --time=48:00:00       # Set max job time (adjust as needed)
#SBATCH --mem=32G             # Set memory allocation (adjust as needed)
#SBATCH --cpus-per-task=8     # Number of cores per task (adjust as needed)
#SBATCH --nodes=1             # Number of nodes
#SBATCH --partition=batch     # Use appropriate partition (e.g., batch, short, etc.)

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

