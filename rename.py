import os
import pandas as pd

# Define paths
excel_path = "/scratch/nf26742/VCF_Per_Country/rename_list.xlsx"
vcf_dir = "/scratch/nf26742/VCF_Per_Country/Algeria_VCF/"

# Load Excel data
df = pd.read_excel(excel_path, header=None, names=["original", "year"])

# Go through each row in the Excel file
for _, row in df.iterrows():
    original_base = row["original"]
    year = row["year"]

    # Look for any .vcf file in the directory that contains the original name
    for fname in os.listdir(vcf_dir):
        if fname.endswith(".vcf") and original_base in fname:
            old_path = os.path.join(vcf_dir, fname)

            # Extract country from the original name
            parts = original_base.split("_")
            country = parts[0].capitalize()  # e.g., 'algeria' -> 'Algeria'

            # Extract SeqID (assumes last part)
            seqid = parts[-1]

            # Create new name: Country_Year_SeqID.vcf
            new_fname = f"{country}_{year}_{seqid}.vcf"
            new_path = os.path.join(vcf_dir, new_fname)

            # Rename the file
            os.rename(old_path, new_path)
            print(f"Renamed: {fname} -> {new_fname}")
