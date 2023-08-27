## Process {b*} STEP 5 ~ 10

#!/bin/bash
set -e

# Define base_path and other global vars
base_path=$(pwd)

process_file() {
    local i=$1
    local j=$2
    local prev_i=$3
    local prev_j=$4
    
    local current_file="b${i}${j}"
    local prev_file="z${prev_i}${prev_j}"
    
    if [ ! -f "${prev_file}" ]; then
        prev_file="b${prev_i}${prev_j}"
    fi

    if [ ! -f "${prev_file}" ]; then
        echo "${current_file} skip"
        return
    fi

    echo "Processing ${current_file} with ${prev_file}"

    awk -v OFS='\t' 'NR==FNR{a[$1]=$2;} NR!=FNR && a[$1] {print $0}' "${current_file}" "${prev_file}" > "a${i}${j}"
    awk -v OFS='\t' 'NR==FNR{S[$1]=$0; next} NR>FNR{print S[$1],$8}' "${current_file}" "a${i}${j}" > "c${i}${j}"
    awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' "c${i}${j}" > "z${i}${j}"
}

cd "${base_path}"

num=5
c=1<<num-1

echo "b_index $c"

for ((i=0; i<num; i++)); do
    for ((j=1; j<=c; j++)); do
        file_name="b${i}${j}"
        
        if [ ! -f "${file_name}" ]; then
            echo "${file_name} not existing"
            continue
        fi

        if (( j % 2 == 0 )); then
            process_file ${i} ${j} $(($i-1)) $(($j/2))
        elif (( j == 1 )); then
            echo "ty3 ${file_name} to z${i}${j}" 
            cp "${file_name}" "z${i}${j}"
        elif (( j % 4 == 3 )); then
            process_file ${i} ${j} $(($i-2)) $(($j+1)/4)
        else
            echo "ty4 ${file_name} unhandled"
        fi
    done
done

# Remove empty files
find . -type f -empty -delete
echo "done"

# Execute the R Code
Rscript - <<EOF

# Load R Libraries
library(tidyverse)

set_wd <- function(path) {
  if(!dir.exists(path)) {
    stop(paste("Directory does not exist:", path))
  }
  setwd(path)
}

base_path <- Sys.getenv("base_path")

create_dirs(base_path, "wtC", "t", "Format", "Format/QUERY", "Format/REF")

# Move files
files_to_move <- list.files(pattern = "{b*}|Flen.txt", full.names = TRUE)
if(length(files_to_move) > 0) {
  file.move(files_to_move, file.path(base_path, "wtC", "t"))
}

flen_data <- read.csv(file.path(base_path, "wtC", "t", "Flen.txt"), header = FALSE, col.names = c("id", "len"))
histogram_plot <- ggplot(flen_data, aes(x = len)) + 
  geom_histogram(binwidth = diff(range(flen_data$len)) / 200) +
  theme_classic() +
  ggtitle("Len")

ggsave(file.path(base_path, "wtC", "t", "dlen.png"), plot = histogram_plot, width = 25, height = 10)

process_directory_files <- function(directory_path) {
  files <- list.files(directory_path, pattern = "*.txt", full.names = TRUE)
  lapply(files, function(file_path) {
    data <- read.csv(file_path, header = FALSE, sep = "\t")
    data
  })
}

query_results <- process_directory_files(file.path(base_path, "Format", "QUERY"))
ref_results <- process_directory_files(file.path(base_path, "Format", "REF"))

process_files <- function(directory_path, prefix) {
  file_names <- list.files(directory_path, pattern = paste0(prefix, "z{1}"), full.names = TRUE)
  if (length(file_names) == 0) {
    stop("No files found in directory.")
  }
  combined_data <- read.csv(file_names[1])
  for(i in 2:length(file_names)){
    next_data <- read.csv(file_names[i])
    combined_data <- merge(combined_data, next_data, by = "id", all = TRUE)
  }
  invalid_cols <- which(sapply(combined_data, function(col) all(is.na(col) | col == "")))
  combined_data <- combined_data[-invalid_cols]
  combined_data[is.na(combined_data)] <- ""
  return(combined_data)
}

query_combined <- process_files(query_path, "q")
write.csv(query_combined, file.path(base_path, "qnew.csv"), row.names = FALSE, col.names = TRUE)

ref_combined <- process_files(ref_path, "r")
write.csv(ref_combined, file.path(base_path, "rnew.csv"), row.names = FALSE, col.names = TRUE)

EOF

