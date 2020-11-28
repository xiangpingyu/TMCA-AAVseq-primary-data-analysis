# PBAAVmap
---
• PBAAVmap is a pipeline to characterize the molecular state of AAV vector genomes on top of long reads mapping.

Usage
---
• Environment Setup
  
  If rerun the same analysis, make sure that all the required files are in the working directory. Commands executed under the Linux terminal are prefixed with a “$” character.

1.	Open the linux terminal and create a working directory
  
  $mkdir work_directory
  
  $cd work_directory

2.	Download the raw sequencing files and database files
  
  *.subreads.bam, m*.subreads.xml, adapters.fasta, ref.fasta, etc.

3.  Software installation: 
  
  Recalladaptor: https://github.com/PacificBiosciences/recalladapters
  
  PacBio CCS: https://github.com/PacificBiosciences/ccs
  
  Minimap2: https://github.com/lh3/minimap2
  
  Levenshtein.raio: https://pypi.org/project/python-Levenshtein
  
  Seqkit-tools: https://anaconda.org/bioconda/seqkit



• Preprocessing
1.	Subreads Output
  
  $recalladapters -s m*.subreads.xml -o output_subreads_bam --disableAdapterCorrection --adapters adapters.fasta

2.	HiFi Reads Output	 
  
  $ccs --minPasses 3 --min-rq 0.99 --report-file output_txt output_subreads_bam outccs_bam	

3.	Convert bam to fasta format
  
  $samtools view outccs_bam | awk '{OFS="\t"; print ">"$1"\n"$10}' - > outccs_fasta

4.	Length distribution of HiFi reads
  
  $seqkit fx2tab -l -n -i -H outccs_fasta > ccslen_txt

5.  Calculate similarity between raw sequence, all_F_fasta and their own reverse-complement
  
  $python2 similarity.py all_F_fasta sim_txt
  
  

• Process BLAST-based Alignment
1. Subsample your target sequencing files F_fasta from raw filtered sequences all_F_fasta
  
  $seqkit seq -m {min-len} -M {max-len} -w 0 all_F_fasta > F_fasta
  
  Note that: set the minimum or maximum of size range based on the project. The output F_fasta in each size range used for further alignment analysis.

2. Blast the selected subsampled sequence file to the reference genome ref_fasta



• Example in one size range
  
  $makeblastdb -in ref.fasta -dbtype nucl
  
  $blastn -db ref.fasta -query F_fasta -task blastn -outfmt 6 -max_hsps 1 -out b1
  
  $python2 LS.py F_fasta b1 L1-1
  
  $python2 RS.py F_fasta b1 L1-2
  
  Note that: The number of alignment loop in specific length range based on the project. For each loop, get unmatched fragments in the previous alignment of the same HiFi read, on left or right sides for next alignment, in Python script with LS.py and RS.py, respectively.
  
  ![image](https://github.com/xiangpingyu/PBVmap/blob/main/images/Alignments.png)



• Visualize Alignments in Windows
1. Creat work_directory Folder on Windows and place the b* alignment files into it.
2. Open the Ref_T.xlsm and Query_T.xlsm template, and all b*, copy the id of reads from b1 file into the first column of Ref_T.xlsm and Query_T.xslm, and process the VLoopUp in the two templates.
3. Copy the data from the Ref_T and Query_T without format into ref.xslm and query.xlsm, respectively. And then run the VBA code to discard the invalid data.
4. Set the filters in the ref.xlsm, conditional formatting the regions in different color.
5. Calculate the ratio of specific rAAV configuration based on the color format configurations in the ref.xlsm.



• Example: cell value between 1 and 145 for ITR region.
  
  ![image](https://github.com/xiangpingyu/PBVmap/blob/main/images/Ref.xlsm.PNG)



Publications
---
