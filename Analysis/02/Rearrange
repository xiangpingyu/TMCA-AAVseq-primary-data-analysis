## Process {b*}  
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

## Set R working PATH. (#R Script)
## Note that, place STEP 4 {b*} and Flen.txt in the patht fold.
patht <- getwd()
pathf <- file.path(patht, "Format")
pathQ <- file.path(patht, "QUERY")
pathR <- file.path(patht, "REF")

## Size distribution, load Flen.txt in the R working directory. (#R Script)
setwd(patht)
# Read data
dlen <- read.csv(file.path(patht, "Flen.txt"), sep = "")
names(dlen) <- c("id","len")
as.numeric(dlen$len)
g <- ggplot(data=dlen,aes(x=len)) +
    geom_histogram(bins=diff(range(dlen$len)/200)) +
    theme_classic() +
    ggtitle("Len")
ggsave("dlen.png",width=25, height=10)

## Process to earrange b*, then get the u.csv, for 03Visualization.
python 2_1* && python 2_2* && python 2_3* && python 2_4*

'''------------------------------------------------------------------------------------'''


