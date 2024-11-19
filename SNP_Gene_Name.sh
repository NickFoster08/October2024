#!/bin/bash
#SBATCH --job-name=Replace_Coord_Gene_Name      # Job name
#SBATCH --partition=batch                     # Partition (queue) name
#SBATCH --ntasks=1                            # Run on a single CPU
#SBATCH --cpus-per-task=8                     # Number of cores per task
#SBATCH --mem=40gb                            # Job memory request
#SBATCH --time=02-00:00:00                    # Time limit hrs:min:sec
#SBATCH --output=/scratch/nf26742/scratch/log.%j.out  # Standard output log
#SBATCH --error=/scratch/nf26742/scratch/log.%j.err   # Standard error log

#SBATCH --mail-type=END,FAIL                  # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=nf26742@uga.edu           # Where to send mail

# Set output directory variable
OUTDIR=/scratch/nf26742/BovMor1/fastqs/Gene_Names_File

# Create the output directory if it doesn't exist
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

# Load necessary modules
module load pandas/1.0.5-foss-2022a-Python-3.10.4
module load openpyxl

# Run the pandas code directly in the SLURM script
python - <<EOF
import pandas as pd

# Load the SNP Excel file
snp_df = pd.read_excel(
    '/scratch/nf26742/BovMor1/fastqs/VCF_Files/all_vcf/all_vcf_sorted_table-2024-11-18_16-27-19.xlsx',
    engine='openpyxl'
)

# Load the GFF3 file for gene annotations
gff3_file = '/scratch/nf26742/BovMor1/fastqs/sequence.gff3'

# Load the GFF3 file into a DataFrame
gff_df = pd.read_csv(gff3_file, sep='\t', comment='#', header=None)
gff_df.columns = ['seqid', 'source', 'type', 'start', 'end', 'score', 'strand', 'phase', 'attributes']

# Function to map SNP coordinates to gene names
def map_snp_to_gene(snp):
    chromosome, position = snp.split(":")
    position = int(position)

    # Filter genes based on the SNP position
    relevant_genes = gff_df[(gff_df['seqid'] == chromosome) & (gff_df['start'] <= position) & (gff_df['end'] >= position)]

    if not relevant_genes.empty:
        # Extract gene names from attributes (assuming gene names are listed here)
        gene_names = relevant_genes['attributes'].str.extract('ID=([^;]+)')
        return gene_names.iloc[0, 0] if not gene_names.empty else 'No_gene_found'
    else:
        return 'No_gene_found'

# Apply SNP to gene mapping for all SNP columns (except the first one, which is the sample name)
snp_columns = snp_df.columns[1:]  # Skip the first column, which is the sample names
mapped_genes = snp_df[snp_columns].applymap(map_snp_to_gene)

# Combine original SNP data with mapped gene names
result_df = pd.concat([snp_df, mapped_genes], axis=1)

# Save the result to an output file
output_file = '/scratch/nf26742/BovMor1/fastqs/Gene_Names_File/mapped_snp_genes.xlsx'
result_df.to_excel(output_file, index=False)

print(f"Mapped gene names saved to {output_file}")
EOF
