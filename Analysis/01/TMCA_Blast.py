import os

def run_blast(query_file, db_file, output_file):
    blast_command = f"blastn -query {query_file} -db {db_file} -outfmt 6 -max_hsps 1 -out {output_file}"
    os.system(blast_command)

def process_files(query_file, blast_output, round_number, file_number):
    # Calculate new file numbers for LS and RS
    new_file_number_1 = file_number * 2 - 1
    new_file_number_2 = file_number * 2

    # Construct new filenames for LS and RS output
    ls_output_file = f"L{round_number}{new_file_number_1}.fasta"
    rs_output_file = f"L{round_number}{new_file_number_2}.fasta"

    # Run LS.py and RS.py with the appropriate arguments
    ls_command = f"python LS.py {query_file} {blast_output} {ls_output_file}"
    rs_command = f"python RS.py {query_file} {blast_output} {rs_output_file}"
    os.system(ls_command)
    os.system(rs_command)

    return ls_output_file, rs_output_file

def main():
    db_file = "ref.fasta"
    round_number = 1
    files_to_process = [("L01.fasta", 1)]

    while round_number <= 5:  # We will run the loop for 5 rounds as per your example
        new_files_to_process = []
        for query_file, file_number in files_to_process:
            # Generate the appropriate output file name based on the current file number without leading zeros
            output_file = f"b{round_number - 1}{file_number}"
            run_blast(query_file, db_file, output_file)
            ls_output_file, rs_output_file = process_files(query_file, output_file, round_number, file_number)
            new_files_to_process.extend([(ls_output_file, file_number * 2 - 1), (rs_output_file, file_number * 2)])
        
        files_to_process = new_files_to_process
        round_number += 1

if __name__ == "__main__":
    main()
