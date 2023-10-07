## Process {b*} STEP 5 ~ 10
## Load R Libraries
# List of libraries
library_list <- c("ggplot2", "rJava", "xlsxjars", "readxl", "dplyr", "tidyr", 
                  "reshape2", "png", "data.table", "ggpubr", "customLayout", 
                  "gridExtra", "grid", "cowplot", "RColorBrewer")

# Install any missing packages
new_packages <- library_list[!(library_list %in% installed.packages()[,"Package"])]
if(length(new_packages) > 0) install.packages(new_packages)

# Load the libraries
lapply(library_list, require, character.only = TRUE)

## STEP 5: Set R working PATH. (#R Script)
## Note that, place STEP 4 {b*} and Flen.txt in the patht fold.
patht <- getwd()
pathf <- file.path(patht, "Format")
pathQ <- file.path(patht, "QUERY")
pathR <- file.path(patht, "REF")

## STEP 6: Size distribution, load Flen.txt in the R working directory. (#R Script)
setwd(patht)
# Read data
dlen <- read.csv(file.path(patht, "Flen.txt"), sep = "")
names(dlen) <- c("id","len")
as.numeric(dlen$len)
g <- ggplot(data=dlen,aes(x=len)) +
    geom_histogram(bins=diff(range(dlen$len)/200)) +
    theme_classic() +
    ggtitle("Len")

## plot output
ggsave("dlen.png",width=25, height=10)

## STEP 7: Rearrange b*

## STEP 8:  Combine rnew.csv and qnew.csv into u.csv.  (#R)
setwd(patht)
ur <- read.csv("rnew.csv")
uq <- read.csv("qnew.csv")
u <- bind_cols(ur, uq)
u[is.na(u)] <- ""
write.csv(u,"u.csv",col.names=T, row.names=F)
## Note that, set 1st col name in u.csv to id.
'''------------------------------------------------------------------------------------'''


