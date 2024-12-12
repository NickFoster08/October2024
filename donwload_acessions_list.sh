#!/bin/bash
#SBATCH --job-name=download_sra_Accessions      # Job name
#SBATCH --partition=batch           # Partition (queue) name
#SBATCH --ntasks=1                  # Run on a single CPU
#SBATCH --cpus-per-task=2           # Number of cores per task
#SBATCH --mem=10gb                  # Memory allocation
#SBATCH --time=24:00:00             # Time limit
#SBATCH --output=download_sra.log   # Standard output log
#SBATCH --error=download_sra.err    # Standard error log

# Load the SRA Toolkit
module load SRA-Toolkit/3.0.3-gompi-2022a

# Define directories
ACCESSIONS="/home/nf26742/All_Seqs/Spain/AF_2015/biosample_result_2.txt"  # File containing SRR numbers
OUTPUT_DIR="/home/nf26742/All_Seqs/Spain/AF_2015"  # Directory for downloaded files
mkdir -p $OUTPUT_DIR

# Log the start of the download process
echo "$(date) - Download process started" >> download_sra.log

# Download each accession
while read -r SRR; do
    echo "$(date) - Downloading $SRR..." >> download_sra.log
    prefetch --max-size 50G --output-directory $OUTPUT_DIR $SRR
    if [ $? -eq 0 ]; then
        echo "$(date) - $SRR downloaded successfully." >> download_sra.log
    else
        echo "$(date) - Error downloading $SRR. Check logs for details." >> download_sra.log
    fi
done < $ACCESSIONS

# Log the end of the download process
echo "$(date) - Download process completed" >> download_sra.log
