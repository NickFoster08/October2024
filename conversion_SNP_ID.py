import csv

# Define the input and output file names
input_file = "C:/Users/nf26742/Desktop/VCF Outputs/all_vcf_sorted_NF.csv"
output_file = "C:/Users/nf26742/Desktop/VCF Outputs/positions.bed"

# Open the input and output files
with open(input_file, mode='r') as infile, open(output_file, mode='w') as outfile:
    reader = csv.reader(infile)
    header = next(reader)  # Skip the header row
    
    for row in reader:
        # Extract positions from each column (ignore the 'root' and 'sample' rows)
        for pos in header[1:]:  # Skip the first column (the row labels)
            # Split the position (e.g., NC_000962.3:1005) into chromosome and position
            chrom, position = pos.split(":")
            # Write the chromosome and position to the BED file
            outfile.write(f"{chrom}\t{position}\t{position}\n")
