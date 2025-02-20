#!/bin/bash

# Directory containing the VCF files
VCF_DIR="/scratch/nf26742/VCF_Per_Country/"

# Move into the directory
cd "$VCF_DIR" || { echo "Error: Directory $VCF_DIR not found!"; exit 1; }

# Loop through each VCF file and rename it
for file in *_zc.vcf; do
    mv "$file" "Spain_BF_2015_${file}"
    echo "Renamed: $file -> Spain_BF_2015_${file}"
done

echo "All files have been renamed successfully!"
