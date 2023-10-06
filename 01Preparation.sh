#!/bin/sh

# Author: Sophia Yu
# Email: xyu@aavlab.com


# Define working directories and file names
WORK_DIR="work_directory"
mkdir -p ${WORK_DIR}
cd ${WORK_DIR}

DATA=*.subreadset.xml
REF=ref.fasta
ADAPTER=*.adapters.fasta

OUTPUT_BAM="out.subreads.bam"
OUTPUT_CCS="outccs3.bam"
OUTPUT_FASTA="outccs3.fasta"

#  HiFi Output
recalladapters -s ${DATA} -o ${OUTPUT_BAM} --disableAdapterCorrection --adapters ${ADAPTER}
ccs --minPasses 3 --min-rq 0.99 --report-file report.txt ${OUTPUT_BAM} ${OUTPUT_CCS}
samtools view ${OUTPUT_CCS} | awk '{OFS="\t"; print ">"$1"\n"$10}' > ${OUTPUT_FASTA}

#  Minimap2 Alignments
minimap2 -d ref.min ${REF}
minimap2 -ax map-pb ref.min outccs3.fasta > all.sam
samtools sort -@ 4 -O bam -o all.sorted.bam all.sam
samtools index all.sorted.bam
samtools faidx ${REF}
samtools view -bF 4 all.sorted.bam > all.F.sorted.bam
samtools fasta all.F.sorted.bam > all.F.fasta
seqkit fx2tab -l -n -i -H all.F.fasta > Flen.txt
seqkit seq -m 1000 -M 2000 -w 0 all.F.fasta > t/12/F 
seqkit sample -p 0.2 -w 0 all.F.fasta > Fx.fasta

#  BLAST-Based Alignments
# Ensure ref.fasta, all.F.fasta, LS, and RS are in the working directory

#!/bin/bash

# Constants and initial setup
BLAST_DIR="t"
mkdir -p "${BLAST_DIR}"
cp LS RS "${REF}" "${BLAST_DIR}"
cd "${BLAST_DIR}"
cp ../all.Fasta L01

# Set the number of BLAST alignment loops
let NUM_LOOPS=5
# Uncomment the line below if user input is desired:
# read -p "Enter the number of loops: " NUM_LOOPS

let BLAST_INDEX=$((2**($NUM_LOOPS-1)))
echo "Blast Index: $BLAST_INDEX"

# Create BLAST database from the reference
makeblastdb -in "${REF}" -dbtype nucl

# BLAST alignment and post-processing
for i in $(seq 0 $((NUM_LOOPS-1))); do
    for j in $(seq 1 $BLAST_INDEX); do
        INPUT_FILE="./L${i}${j}"
        
        if [ -f "$INPUT_FILE" ]; then
            # Execute BLAST alignment
            blastn -db "${REF}" -query "$INPUT_FILE" -task blastn -outfmt 6 -max_hsps 1 -out b${i}${j}
            
            # Process BLAST outputs using Python scripts
            echo "Processing LS for: $INPUT_FILE"
            python2 LS "$INPUT_FILE" b${i}${j} L$((i+1))$((j*2-1))
            
            echo "Processing RS for: $INPUT_FILE"
            python2 RS "$INPUT_FILE" b${i}${j} L$((i+1))$((j*2))
        fi
    done    
done

# Notification and result archiving
echo "BLAST alignment completed."
zip -r t.zip b*
