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
BLAST_DIR="t"
mkdir -p ${BLAST_DIR}
cp LS RS ${REF} ./${BLAST_DIR}
cd ${BLAST_DIR}
cp ../all.F.fasta L01

# Setup BLAST alignment loop
let NUM_LOOPS=5
let BLAST_FACTOR=2**$((NUM_LOOPS-1))
echo "b_index $BLAST_FACTOR"

makeblastdb -in ${REF} -dbtype nucl

for i in $(seq 1 $NUM_LOOPS); do
    for j in $(seq 1 $BLAST_FACTOR); do
        if [ -f "./L$((i-1))$j" ]; then
            blastn -db ${REF} -query L$((i-1))$j -task blastn -outfmt 6 -max_hsps 1 -out b$((i-1))$j
            echo "Processing LS"
            python2 LS L$((i-1))$j b$((i-1))$j L${i}$((j*2-1))
            echo "Processing RS"
            python2 RS L$((i-1))$j b$((i-1))$j L${i}$((j*2))
        fi
    done    
done
echo "BLAST alignment completed"

# Archive results
zip -r t.zip b*
