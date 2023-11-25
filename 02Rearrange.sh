#!/bin/bash

# Ensure the script stops on any error
set -e

# Notify the start of script execution
echo "Starting the rearrangement process..."

# [2] Rearrange {b*}
echo "Running Python scripts for rearrangement..."
python Rearrange1_sorted_qcom.py 
python Rearrange2_rearrange_qnew.py 
python Rearrange31_qnew_reordered_q.py
python Rearrange32_qnew_reordered_s.py

# Check if the necessary files exist
if [[ ! -f "export/t/urnew.csv" ]] || [[ ! -f "export/t/uqnew.csv" ]]; then
    echo "Error: Required files do not exist."
    exit 1
fi

# Transform urnew.csv and uqnew.csv into a space-delimited format
echo "Transforming urnew.csv and uqnew.csv file formats..."
awk '{for (i=1; i<=NF; i++) printf "%s%s", $i, (i==NF ? "\n" : ",")} ' export/t/urnew.csv > export/t/urnew_modified.csv
awk '{for (i=1; i<=NF; i++) printf "%s%s", $i, (i==NF ? "\n" : ",")} ' export/t/uqnew.csv > export/t/uqnew_modified.csv

# Continue with further Python processing
echo "Merging and further processing data..."
python Rearrange4_qs_merged_u.py

# Notify the script execution completion
echo "Script execution completed."

