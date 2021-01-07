#!/bin/sh

#Author: Sophia Yu
#Email: xyu@aavlab.com
#Date: 28-08-2019

mkdir work_directory
cd work_directory
# DATA=*subreadset.xml
REF=ref.fasta
# Adapter=*adapters.fasta

## STEP 1: Download raw sequencing files, including *subreadset.xml, *subreads.bam, *subreads.bam.bai, *.adapters.fasta, ref.fasta.
#tar -zcvf *.tar.gz *

## STEP 2: HiFi Output. (Bash)
recalladapters -s ${DATA} -o out_subread.bam --disableAdapterCorrection --adapters ${Adapter}   #-j 
## CCS mode: (optional) --minPasses, --min-rq
ccs --minPasses 3 --min-rq 0.99 --report-file report.txt out_subread.bam outccs3.bam  #-j 
## bam to fasta
samtools view outccs3.bam | awk '{OFS="\t"; print ">"$1"\n"$10}' - > outccs3.fasta

## (Optional): HiFi Status. (Bash)
# samtools idxstats all.F.sorted.bam
# seqkit stats outccs.fasta
# seqkit fx2tab -l -n -i -H outccs3.fasta > ccs3len.txt

## STEP 3: Minimap2 Alignments. (Bash)
minimap2 -d ref.min ${REF}
minimap2 -ax map-pb ref.min outccs3.fasta > all.sam
samtools sort -@ 4 -O bam -o all.sorted.bam all.sam
samtools index all.sorted.bam
samtools faidx ${REF}
samtools view -bF 4 all.sorted.bam > all.F.sorted.bam
samtools fasta all.F.sorted.bam > all.F.fasta
seqkit fx2tab -l -n -i -H all.F.fasta > Flen.txt

## STEP 4: BLAST-Based Alignments: e.g. num_loop=5, b0-b4.  (Bash)
## Note: Place ref.fasta, all.F.fasta, LS and RS in the same working directory.
mkdir t
cp LS RS ${REF} ./t
cd t
cp ./all.F.fasta L01

# (i) Choose the BLAST alignment loop number. 
# read -p "number of loop：" num;
let num=5
# (ii) Blast alignments.
b=1
let num1=$num-1
for i in $(seq 1 $num1)
do
    let "b=2*b"
done
echo "b_index $b"
makeblastdb -in ${REF} -dbtype nucl;
for i in $(seq 1 $num)
do
    let i1=$i-1
    for j in $(seq 1 $b)
    do
    if [ ! -f "./L$i1$j" ]
    then
    echo " "
    else
    blastn -db ${REF} -query L$i1$j -task blastn -outfmt 6 -max_hsps 1 -out b$i1$j;   
    let ja=$j*2-1    
    let jb=$j*2    
    echo "LS"
    python LS L$i1$j b$i1$j L$i$ja
    echo "RS"
    python RS L$i1$j b$i1$j L$i$jb
    fi
    done    
done
echo "BLAST done"
