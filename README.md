# VMP-Seq
---
A pipeline to characterize the molecule state of AAV genomes on top of long reads mapping.

## Usage
---
### Environment Setup
  
If re-run the same analysis, make sure that all the required files are in the working directory. 
  
### Software installation

- Install anaconda (https://anaconda.org/anaconda/git) to perform the corresponding SMRT or R packages.  These SMRT packages can be freely git cloned from (https://github.com/PacificBiosciences)
  
- Get the SMRT_Link documents supports from (https://www.pacb.com/support/software-downloads/)
  
- recalladapters: https://github.com/PacificBiosciences/recalladapters
  
- CCS: https://github.com/PacificBiosciences/ccs 
  
- Minimap2: https://github.com/lh3/minimap2
  
- BLAST: https://anaconda.org/bioconda/blast
  
- Seqkit-tools: https://anaconda.org/bioconda/seqkit
  
- R: https://anaconda.org/r/r-base

### Procedure
（i) Preparation.sh

Check for Required Files: The script checks if specific files are present, which seem to be files output by Pacific Biosciences sequencing platforms. It checks for the presence of files like subreadset.xml, subreads.bam, etc., and terminates if they are missing.

HiFi Output Processing: The script performs adapter recall, which seems to be some kind of data cleanup. Following this, it performs a CCS (Circular Consensus Sequence) generation, which creates high-fidelity reads. Finally, it processes the output to get the sequences in FASTA format.

Minimap2 Alignments: The Minimap2 tool is used to align the HiFi reads to a reference genome. It generates various output files and does some additional processing with the samtools package.

BLAST-Based Alignments: Using BLAST, the script performs DNA sequence alignments in a looped fashion. Two python scripts (LS and RS) seem to do further processing on the BLAST results. 

      
(ii) Rearrange.sh  

Bash Script:

Function process_file(): a series of operations that are performed on some BLAST results or some tabular data. 

Main Execution Loop: go through a series of files with a specific naming convention and processes them depending on certain conditions. 

Execute R Code: Finally, it executes an embedded R script.

R Script:

Data Visualization: A histogram is created from a file Flen.txt and saved as dlen.png.

Data Processing: a series of functions and operations intended to process files in specific directories, merge their data, and then save combined results. 

(iii) <Visualization.sh： Caculate the ratio of main molecule configuration.

NOTE that, if process wtAAV sequencing reads, update the Subgenome() and plot() functions.

Update format.csv with important sites of target, AAV virus genomes. (ITR, promoter, etc.)

Subgenome(): calculate main configurations, such as FULL, SBG, ICG, GDM.



---

