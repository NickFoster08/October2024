import sys
from Bio import SeqIO

# Get the input and output file paths from command-line arguments
input_file = sys.argv[1]
output_file = sys.argv[2]

# Parse the .gbff file and write it as a .gbk file
with open(input_file, "r") as in_file, open(output_file, "w") as out_file:
    # Parse and write sequences
    SeqIO.write(SeqIO.parse(in_file, "genbank"), out_file, "genbank")

print(f"Conversion from {input_file} to {output_file} completed successfully.")
