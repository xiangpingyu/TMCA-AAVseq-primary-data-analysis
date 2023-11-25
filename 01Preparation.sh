#!/bin/sh

# Author: Sophia Yu
# Email: xyu@aavlab.com

## Define working directories and file names
IN_DIR="raw_data"
mkdir -p export
export_folder="export"

## Place input files in the WD
DATA="$IN_DIR/*.subreadset.xml"
DATA_FILE=$(basename $(ls $IN_DIR/*.subreadset.xml | head -1))
DATA_NAME=${DATA_FILE%.subreadset.xml}

REF="$IN_DIR/*ref.fasta"
ADAPTER="$IN_DIR/*.adapters.fasta"

## output files
OUTPUT_BAM="$export_folder/${DATA_NAME}.subreads.bam"
OUTPUT_CCS="$export_folder/${DATA_NAME}_outccs3.bam"
OUTPUT_FASTA="$export_folder/${DATA_NAME}_outccs3.fasta"

## HiFi Output
recalladapters -s "$DATA" -o "$OUTPUT_BAM" --disableAdapterCorrection --adapters "$ADAPTER"
ccs --minPasses 3 --min-rq 0.99 --report-file "$export_folder/report.txt" "$OUTPUT_BAM" "$OUTPUT_CCS"
samtools view "$OUTPUT_CCS" | awk '{OFS="\t"; print ">"$1"\n"$10}' > "$OUTPUT_FASTA"

## Minimap2 Alignments
minimap2 -d "$export_folder/ref.min" "$REF"
minimap2 -ax map-pb "$export_folder/ref.min" "$OUTPUT_FASTA" > "$export_folder/${DATA_NAME}_all.sam"
samtools sort -@ 4 -O bam -o "$export_folder/${DATA_NAME}_all.sorted.bam" "$export_folder/${DATA_NAME}_all.sam"
samtools index "$export_folder/${DATA_NAME}_all.sorted.bam"
samtools faidx "$REF"
samtools view -bF 4 "$export_folder/${DATA_NAME}_all.sorted.bam" > "$export_folder/${DATA_NAME}_all.F.sorted.bam"
samtools fasta "$export_folder/${DATA_NAME}_all.F.sorted.bam" > "$export_folder/${DATA_NAME}_all.F.fasta"

## Blast preparation
cp "$export_folder/${DATA_NAME}_all.F.fasta" "$export_folder/${DATA_NAME}_L01.fasta"
cp $REF "$export_folder/ref.fasta"
makeblastdb -in "$export_folder/ref.fasta" -dbtype nucl
python TMCA_AAVseq_blast.py  # Assuming the python script can take parameters for input and output directory


## SeqKit operations
seqkit fx2tab -l -n -i -H "$export_folder/${DATA_NAME}_L01.fasta" > "$export_folder/${DATA_NAME}_Flen.txt"
# seqkit seq -m 1000 -M 2000 -w 0 "$export_folder/all.F.fasta" > "$export_folder/t/12/F" 
# seqkit sample -p 0.2 -w 0 "$export_folder/all.F.fasta" > "$export_folder/FX.fasta"

Rscript Flen.r