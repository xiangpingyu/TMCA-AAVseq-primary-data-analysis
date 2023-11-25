## Process {b*}
## Load R Libraries
library_list <- c("ggplot2", "rJava", "xlsxjars", "readxl", "dplyr", "tidyr", 
                  "reshape2", "png", "data.table", "gridExtra", 
                  "grid", "cowplot", "RColorBrewer", "ggpubr")

installed_packages <- rownames(installed.packages())
for (pkg in library_list) {
  if (!pkg %in% installed_packages) {
    install.packages(pkg)
  }
}


## Load the libraries
lapply(library_list, function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    warning(paste("Package", pkg, "is not installed or loaded."))
  }
})


# install.packages("ggpubr")

## Load the libraries
lapply(library_list, require, character.only = TRUE)

## Define the export folder path
export_folder <- "export"

## Check if the export folder exists and set as the working path
if (!dir.exists(export_folder)) {
    stop(paste("The folder", export_folder, "does not exist."))
}
patht <- file.path(getwd(), export_folder)  # Path to the export folder


## Read data
# List all files that match the pattern *_Flen.txt in the export folder
file_list <- list.files(path = patht, pattern = "_Flen\\.txt$", full.names = TRUE)
if (length(file_list) == 0) {
    stop("No files matching pattern '*_Flen.txt' found in the export folder.")
}

# Assuming you want to process the first file (or adjust as necessary)
file_path <- file_list[1]
dlen <- read.csv(file_path, sep = "\t") # Assuming tab-separated files
names(dlen) <- c("id", "len")
dlen$len <- as.numeric(dlen$len)

# Extracting the prefix from the filename
file_prefix <- sub("_Flen\\.txt$", "", basename(file_path))

## Plotting
g <- ggplot(data=dlen, aes(x=len)) +
    geom_histogram(bins=30) + # Adjust the number of bins as needed
    theme_classic() +
    xlab("Length") + ylab("Frequency") +
    ggtitle("Length Distribution")


## Saving the plot with the same prefix as Flen.txt in the export folder
output_plot_name <- paste0(export_folder, "/", file_prefix, "_dlen.png")
ggsave(output_plot_name, plot=g, width=10, height=6) # Adjust dimensions as needed
