#!/bin/bash
#SBATCH --job-name=Change_names_Mor_Bovis_Bioproject        # Job name
#SBATCH --partition=batch                      # Partition (queue) name
#SBATCH --ntasks=1                             # Run on a single CPU
#SBATCH --cpus-per-task=2                      # Number of cores per task
#SBATCH --mem=10gb                             # Job memory request
#SBATCH --time=00-01:00:00                     # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                   # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu            # Where to send mail

# Set output directory variable
OUTDIR="/home/nf26742/BovMor1/fastqs" 
###Nick I recommend moving your fastqs to scratch due to the 200GB memory limit in home.

#Move to working directory
cd $OUTDIR

# Loop through all files with the pattern *_R1_001.fastq.gz
for file in *_R1_001.fastq.gz; do
   # Extract the sample name by removing '_R1_001.fastq.gz' from the filename
   sample_name=$(echo "$file" | sed 's/_R1_001.fastq.gz//')
   
   # Construct the new filename
   new_name="${sample_name}_R1.fastq.gz"
   
   # Rename the file
   mv "$file" "$new_name"
   
   # Output the changes
   echo "Renamed $file to $new_name"
done

# Loop through all files with the pattern *_R2_001.fastq.gz
for file in *_R2_001.fastq.gz; do
   # Extract the sample name by removing '_R2_001.fastq.gz' from the filename
   sample_name=$(echo "$file" | sed 's/_R2_001.fastq.gz//')
   
   # Construct the new filename
   new_name="${sample_name}_R2.fastq.gz"
   
   # Rename the file
   mv "$file" "$new_name"
   
   # Output the changes
   echo "Renamed $file to $new_name"
done