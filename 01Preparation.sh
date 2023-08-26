#!/bin/sh

# Metadata
## Author: Sophia Yu
## Email: xyu@aavlab.com

# Constants
NUM_THREADS=4    # Modify this for parallel processing capabilities

# STEP 1: Download and Organize Raw Sequencing Files
# Check for required files
if [[ ! -f *subreadset.xml || ! -f *subreads.bam || ! -f *subreads.bam.bai || ! -f *adapters.fasta || ! -f ref.fasta ]]; then
    echo "Error: Not all required files are present."
    exit 1
fi

# Archive and create workspace
tar -zcvf sequencing_files.tar.gz *
mkdir -p work_directory
cd work_directory

# Setup file references
DATA=$(ls ../*subreadset.xml)
ADAPTER=$(ls ../*adapters.fasta)
REF=../ref.fasta

echo "Data file: $DATA"
echo "Adapter file: $ADAPTER"
echo "Reference file: $REF"

# STEP 2: HiFi Output
recalladapters -s "$DATA" -o out_subread.bam --disableAdapterCorrection --adapters "$ADAPTER"
ccs --minPasses 3 --min-rq 0.99 --report-file report.txt out_subread.bam outccs3.bam
samtools view outccs3.bam | awk '{OFS="\t"; print ">"$1"\n"$10}' > outccs3.fasta

# STEP 3: Minimap2 Alignments
minimap2 -d ref.min "$REF"
minimap2 -ax map-pb ref.min outccs3.fasta > all.sam
samtools sort -@ "$NUM_THREADS" -O bam -o all.sorted.bam all.sam
samtools index all.sorted.bam
samtools faidx "$REF"
samtools view -bF 4 all.sorted.bam > all.F.sorted.bam
samtools fasta all.F.sorted.bam > all.Ffasta
seqkit fx2tab -l -n -i -H all.F.fasta > Flen.txt

# STEP 4: BLAST-Based Alignments
mkdir -p t
cp LS RS "$REF" ./t
cd t
cp ../all.Ffasta L01

NUM_LOOPS=5
b=1

# Calculate b
for _ in $(seq 1 $((NUM_LOOPS-1))); do
    b=$((2*b))
done

echo "b_index $b"
makeblastdb -in "$REF" -dbtype nucl

# Loop through BLAST alignments
for i in $(seq 1 $NUM_LOOPS); do
    prev_i=$((i-1))
    for j in $(seq 1 $b); do
        if [ -f "./L$prev_i$j" ]; then
            blastn -db "$REF" -query L$prev_i$j -task blastn -outfmt 6 -max_hsps 1 -out b$prev_i$j

            ja=$((j*2-1))
            jb=$((j*2))

            python2 LS L$prev_i$j b$prev_i$j L$i$ja
            python2 RS L$prev_i$j b$prev_i$j L$i$jb
        fi
    done
done

echo "BLAST alignment done"
zip -r t.zip b*
