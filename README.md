# PBVmap
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

(i) Download raw sequencing data and run CCS3 and Minimap2 alignments to output Aligned reads. (#Bash)
  
      * <Preparation.sh> STEP 1~3, output aligned all.F.fasta data.

(ii) BLAST-Based Alignments. (#Bash)
      ![Mapping](https://github.com/xiangpingyu/PBVmap/blob/main/Image/Mapping.jpg)
  
      Note that, please place ref.fasta, all.F.fasta, LS and RS in the working directory.
  
      Firstly, choose the loop number.
  
      * <Preparation.sh> STEP 4
      
      OUTPUT: "b*"
      
(iii) Alignments Visualization. (#Bash, R and VBA)
  
      * <Rearrange.sh> STEP 5~10, rearrange query&ref of "b*" output files.
      
      NOTE that, need to discard blank cells in "*new.csv" with VBA code.
      
      OUTPUT: "u.csv"
      
      (Optional) Processing a large dataset of qnew.csv and rnew.csv into multiple files. (#Bash, R and VBA)

(iv) Caculate the ratio of different molecule configuration. (#R scripts)
  
      * <Visualization.sh> STEP 11~14
      
      NOTE that, 
      STEP 11, update format.csv with important sites of target, AAV virus genomes. (ITR, promoter, etc.)
      STEP 12, <Subgenome() calculate main configurations, such as FULL, SBG, ICG, GDM.
      STEP 13, subsample based on size and process their Subgenome().
      STEP 14, generate Charts.


---

