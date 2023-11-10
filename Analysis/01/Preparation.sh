#!/bin/sh

# Author: Sophia Yu
# Email: xyu@aavlab.com


## Define working directories and file names
WORK_DIR="work_directory"
mkdir -p ${WORK_DIR}
cd ${WORK_DIR}

DATA=*.subreadset.xml
REF=ref.fasta
ADAPTER=*.adapters.fasta

OUTPUT_BAM="out.subreads.bam"
OUTPUT_CCS="outccs3.bam"
OUTPUT_FASTA="outccs3.fasta"

##  HiFi Output
recalladapters -s ${DATA} -o ${OUTPUT_BAM} --disableAdapterCorrection --adapters ${ADAPTER}
ccs --minPasses 3 --min-rq 0.99 --report-file report.txt ${OUTPUT_BAM} ${OUTPUT_CCS}
samtools view ${OUTPUT_CCS} | awk '{OFS="\t"; print ">"$1"\n"$10}' > ${OUTPUT_FASTA}

##  Minimap2 Alignments
minimap2 -d ref.min ${REF}
minimap2 -ax map-pb ref.min outccs3.fasta > all.sam
samtools sort -@ 4 -O bam -o all.sorted.bam all.sam
samtools index all.sorted.bam
samtools faidx ${REF}
samtools view -bF 4 all.sorted.bam > all.F.sorted.bam
samtools fasta all.F.sorted.bam > all.F.fasta

## blast preparation
cp all.F.fasta L01.fasta
makeblastdb -in ref.fasta -dbtype nucl
python TMCA_AAVseq_blast.py

## 
seqkit fx2tab -l -n -i -H all.F.fasta > Flen.txt
#seqkit seq -m 1000 -M 2000 -w 0 all.F.fasta > t/12/F 
#seqkit sample -p 0.2 -w 0 all.F.fasta > Fx.fasta



