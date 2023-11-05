#!/bin/sh

## BLAST-Based Alignments
## Place ref.fasta, all.F.fasta, Flen.txt, LS.py, and RS.py are in the "t" working directory

## Constants and initial setup
BLAST_DIR="t"
mkdir -p "${BLAST_DIR}"
cp LS RS "${REF}" "${BLAST_DIR}"
cd "${BLAST_DIR}"
cp ../all.F.fasta L01.fasta

## Set the number of BLAST alignment loops
let NUM_LOOPS=5
## Uncomment the line below if user input is desired:
## read -p "Enter the number of loops: " NUM_LOOPS

#blast loop in the path where is your sequencing filtered reads and get the match site between ccs reads and reference genome {b*}.
makeblastdb -in ref.fasta -dbtype nucl
#1st loop
blastn -db ref.fasta -query L01.fasta -task blastn -outfmt 6 -max_hsps 1 -out b1
python LS.py L01.fasta b1 L11.fasta
python RS.py L01.fasta b1 L12.fasta
#2nd loop
blastn -db ref.fasta -query L11.fasta -task blastn -outfmt 6 -max_hsps 1 -out b11
python LS.py L11.fasta b11 L21.fasta
python RS.py L11.fasta b11 L22.fasta
blastn -db ref.fasta -query L12.fasta -task blastn -outfmt 6 -max_hsps 1 -out b12
python LS.py L12.fasta b12 L23.fasta
python RS.py L12.fasta b12 L24.fasta
#3rd loop
blastn -db ref.fasta -query L21.fasta -task blastn -outfmt 6 -max_hsps 1 -out b21
python LS.py L21.fasta b21 L31.fasta
python RS.py L21.fasta b21 L32.fasta
blastn -db ref.fasta -query L22.fasta -task blastn -outfmt 6 -max_hsps 1 -out b22
python LS.py L22.fasta b22 L33.fasta
python RS.py L22.fasta b22 L34.fasta
blastn -db ref.fasta -query L23.fasta -task blastn -outfmt 6 -max_hsps 1 -out b23
python LS.py L23.fasta b23 L35.fasta
python RS.py L23.fasta b23 L36.fasta
blastn -db ref.fasta -query L24.fasta -task blastn -outfmt 6 -max_hsps 1 -out b24
python LS.py L24.fasta b24 L37.fasta
python RS.py L24.fasta b24 L38.fasta
#4th loop
blastn -db ref.fasta -query L31.fasta -task blastn -outfmt 6 -max_hsps 1 -out b31
python LS.py L31.fasta b31 L41.fasta
python RS.py L31.fasta b31 L42.fasta
blastn -db ref.fasta -query L32.fasta -task blastn -outfmt 6 -max_hsps 1 -out b32
python LS.py L32.fasta b32 L43.fasta
python RS.py L32.fasta b32 L44.fasta
blastn -db ref.fasta -query L33.fasta -task blastn -outfmt 6 -max_hsps 1 -out b33
python LS.py L33.fasta b33 L45.fasta
python RS.py L33.fasta b33 L46.fasta
blastn -db ref.fasta -query L34.fasta -task blastn -outfmt 6 -max_hsps 1 -out b34
python LS.py L34.fasta b34 L47.fasta
python RS.py L34.fasta b34 L48.fasta
blastn -db ref.fasta -query L35.fasta -task blastn -outfmt 6 -max_hsps 1 -out b35
python LS.py L35.fasta b35 L49.fasta
python RS.py L35.fasta b35 L410.fasta
blastn -db ref.fasta -query L36.fasta -task blastn -outfmt 6 -max_hsps 1 -out b36
python LS.py L36.fasta b36 L411.fasta
python RS.py L36.fasta b36 L412.fasta
blastn -db ref.fasta -query L37.fasta -task blastn -outfmt 6 -max_hsps 1 -out b37
python LS.py L37.fasta b37 L413.fasta
python RS.py L37.fasta b37 L414.fasta
blastn -db ref.fasta -query L38.fasta -task blastn -outfmt 6 -max_hsps 1 -out b38
python LS.py L38.fasta b38 L415.fasta
python RS.py L38.fasta b38 L416.fasta
#5th loop
blastn -db ref.fasta -query L41.fasta -task blastn -outfmt 6 -max_hsps 1 -out b41
blastn -db ref.fasta -query L42.fasta -task blastn -outfmt 6 -max_hsps 1 -out b42
blastn -db ref.fasta -query L43.fasta -task blastn -outfmt 6 -max_hsps 1 -out b43
blastn -db ref.fasta -query L44.fasta -task blastn -outfmt 6 -max_hsps 1 -out b44
blastn -db ref.fasta -query L45.fasta -task blastn -outfmt 6 -max_hsps 1 -out b45
blastn -db ref.fasta -query L46.fasta -task blastn -outfmt 6 -max_hsps 1 -out b46
blastn -db ref.fasta -query L47.fasta -task blastn -outfmt 6 -max_hsps 1 -out b47
blastn -db ref.fasta -query L48.fasta -task blastn -outfmt 6 -max_hsps 1 -out b48
blastn -db ref.fasta -query L49.fasta -task blastn -outfmt 6 -max_hsps 1 -out b49
blastn -db ref.fasta -query L410.fasta -task blastn -outfmt 6 -max_hsps 1 -out b410
blastn -db ref.fasta -query L411.fasta -task blastn -outfmt 6 -max_hsps 1 -out b411
blastn -db ref.fasta -query L412.fasta -task blastn -outfmt 6 -max_hsps 1 -out b412
blastn -db ref.fasta -query L413.fasta -task blastn -outfmt 6 -max_hsps 1 -out b413
blastn -db ref.fasta -query L414.fasta -task blastn -outfmt 6 -max_hsps 1 -out b414
blastn -db ref.fasta -query L415.fasta -task blastn -outfmt 6 -max_hsps 1 -out b415
blastn -db ref.fasta -query L416.fasta -task blastn -outfmt 6 -max_hsps 1 -out b416
