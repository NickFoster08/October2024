#!/bin/bash

# Define the source directory (current directory)
SOURCE_DIR="/scratch/nf26742/AllSeqsAttempt3/"


# Define the target directory
TARGET_DIR="/scratch/nf26742/VCF_Per_Country/Spain_VCF"

# Create the target directory if it does not exist
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

# Move all .zc.vcf files to the target directory
find "$SOURCE_DIR" -name "*_zc.vcf" -exec mv {} "$TARGET_DIR" \;

# Confirm completion
echo "All .zc.vcf files have been moved to $TARGET_DIR."
