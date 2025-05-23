import xml.etree.ElementTree as ET
import os

def fix_xml(file_path, output_path):
    # Check if the file exists
    if not os.path.isfile(file_path):
        print(f"Error: Input file does not exist: {file_path}")
        return
    
    # Read the last few lines of the XML file
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    print("Last few lines of the XML file:")
    for line in lines[-10:]:  # Print the last 10 lines
        print(line.strip())

    # Attempt to parse the XML file
    print(f"Attempting to open: {file_path}")  # Check the path
    try:
        tree = ET.parse(file_path)
        print("XML file is well-formed.")
        return  # If it's already well-formed, exit the function
    except ET.ParseError as e:
        print(f"ParseError: {e}")

    # Open the original file to read and a new file to write the fixed content
    with open(file_path, 'r') as original_file:
        lines = original_file.readlines()

    # Write to a new file
    with open(output_path, 'w') as fixed_file:
        for line in lines:
            # Check for common issues (for example: a line ending without closing a tag)
            if line.strip().endswith('<') or line.strip().endswith('</'):
                print(f"Found unclosed tag in line: {line.strip()}")
                line = line.strip() + ' />\n'  # Add a self-closing tag
            fixed_file.write(line)
    
    print(f"Fixed XML written to {output_path}")

if __name__ == "__main__":
    input_file = '/lustre2/scratch/nf26742/BovMor1/core-snp-clean-try-3.xml'  # Your input file
    output_file = '/lustre2/scratch/nf26742/BovMor1/core-snp-clean-try-3_fixed.xml'  # Output file for fixed XML
    fix_xml(input_file, output_file)
