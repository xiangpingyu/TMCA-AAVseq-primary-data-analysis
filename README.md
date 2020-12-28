# PBVmap
---
PBVmap is a pipeline to characterize the molecular state of AAV vector genomes on top of long reads mapping.

## Usage
---
### Environment Setup
  
If rerun the same analysis, make sure that all the required files are in the working directory. 
  
### Software installation

Install anaconda (https://anaconda.org/anaconda/git) to perform the corresponding SMRT or R packages.  These SMRT packages can be freely git cloned from       https://github.com/PacificBiosciences.  
  
Get the SMRT_Link documents supports from (https://www.pacb.com/support/software-downloads/).
  
recalladapters: https://github.com/PacificBiosciences/recalladapters
  
CCS: https://github.com/PacificBiosciences/ccs 
  
Minimap2: https://github.com/lh3/minimap2
  
BLAST: https://anaconda.org/bioconda/blast
  
Seqkit-tools: https://anaconda.org/bioconda/seqkit
  
R: https://anaconda.org/r/r-base

  
### Procedure

(i) Download raw sequencing files and Run CCS and Minimap2 alignments to output Aligned reads. (Bash)
  
      * <Pipeline.sh> STEP 1~4

(ii) BLAST-Based Alignments. (Bash)
      ![github]
      (https://github.com/xiangpingyu/PBVmap/Picture/Loop.png)
  
      Note: Place ref.fasta, all.F.fasta, LS and RS in the same working directory.
  
      Firstly choose the loop number.
  
      * <Pipeline.sh>  STEP 5
      
(iii) Alignments Visualization. (R scripts)
  
      * <Plot.sh> STEP 1~4, rearrange query and ref b* output alignment. 
      
      OUTPUT: "u.csv"
      
      NOTE: Need to discard blank cells in *new.csv with VBA code.
      
      (Optional): Processing a large dataset of qnew.csv\ rnew.csv into multiple files.

(iv) Caculate the ratio of different molecule configuration. (R scripts)
  
      * <Format.sh>
      
      NOTE: Need to edit the important sites of rAAV virus genome.
      
      Here present some main configurations in rAAV population, SBG, ICG, GDM, etc.





### Publications

  • Subgenomic satellite particle generation in recombinant AAV vectors results from DNA lesion/breakage and non-homologous end joining:                    https://www.biorxiv.org/content/10.1101/2020.08.01.230755v1

  • Satellite subgenomic particles are key regulators of adeno-associated virus life cycle:
  https://www.biorxiv.org/content/10.1101/2020.10.20.346957v1

---

