# PBVmap
---
A pipeline to characterize the molecule state of rAAV genomes on top of long reads mapping.

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
  
      * <Pipeline.sh> STEP 1~3, output aligned data.

(ii) BLAST-Based Alignments. (#Bash)
      ![Mapping](https://github.com/xiangpingyu/PBVmap/blob/main/Image/Mapping.jpg)
  
      Note that, please place ref.fasta, all.F.fasta, LS and RS in the "t" working directory.
  
      Firstly, choose the loop number.
  
      * <Pipeline.sh> STEP 4
      
      OUTPUT: "b*"
      
(iii) Alignments Visualization. (#Bash, R and VBA)
  
      * <Plot.sh> STEP 2, rearrange query&ref of "b*" output files.
      
      NOTE that, need to discard blank cells in "*new.csv" with VBA code.
      
      OUTPUT: "*new.csv", "u.csv"
      
      (Optional) Processing a large dataset of qnew.csv and rnew.csv into multiple files. (#Bash, R and VBA)

(iv) Caculate the ratio of different molecule configuration. (#R scripts)
  
      * <Format.sh>
      
      NOTE that, STEP 1, need to update the important sites of target, rAAV virus genomes. (ITR, promoter, etc.). Here analysis some      identified configurations in rAAV virus population. (TYPE 1~4: FULL, SBG, ICG, GDM)
      
       (Optional) Filter subsample based on size and caculate the ratio of these subgenomes.


### Related Publications

      Subgenomic satellite particle generation in recombinant AAV vectors results from DNA lesion/breakage and non-homologous end joining: https://www.biorxiv.org/content/10.1101/2020.08.01.230755v1

      Satellite subgenomic particles are key regulators of adeno-associated virus life cycle: https://www.biorxiv.org/content/10.1101/2020.10.20.346957v1

---

