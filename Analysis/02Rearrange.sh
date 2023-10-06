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
names(dlen) <- c("id", "len")

# Convert 'len' column to numeric and check for NA values
dlen$len_numeric <- as.numeric(as.character(dlen$len))

# Identify rows where conversion failed
problematic_rows <- dlen[is.na(dlen$len_numeric), ]

# Print the problematic rows
if (nrow(problematic_rows) > 0) {
    print("The following rows have problematic 'len' values:")
    print(problematic_rows)
} else {
    print("No problematic values detected.")
}

# For the purpose of plotting, we'll drop these problematic rows
dlen <- dlen[!is.na(dlen$len_numeric), ]

# Plotting
num_bins <- as.integer(diff(range(dlen$len_numeric)) / 200)
g <- ggplot(data = dlen, aes(x = len_numeric)) +
    geom_histogram(bins = num_bins) +
    theme_classic() +
    ggtitle("Len")

# Save plot
ggsave(file.path(t_path, "dlen.png"), width = 25, height = 10, plot = g)


## STEP 7: Convert {b*} data from step 4. (#Bash)
#!/bin/bash

# Rename files as per requirement (optional)
# for file in b*-*
# do
#     mv "$file" "${file/-/}"
# done

cd {patht}  
# read -p "number of loop：" num;
let num=5

## NOTE that, if $num=5, b0 ~ b4, $c=16
c=1
let num1=$num-1
for i in $(seq 1 $num1)
do
    let "c=2*c"
done
echo "b_index $c"
for ((i=0; i<=$num1; i ++))
    do
        for j in $(seq 1 $c)
            do
            let ja=($j+1)/2
            if [ ! -f "b$i$j" ]
            then
                echo "b$i$j no exiting"
            elif [ $((j%2)) == 0 ]  
            then
                echo "ty1 b$i$j exiting"
                let jb=$j/2
                let i1=$i-1
                if [ ! -f "z$i1$jb" ]
                then
                    if [ ! -f "b$i1$jb" ]
                    then
                        echo "b$i$j skip"
                    else
                        awk -v OFS='\t' 'NR==FNR{a[$1]=$2;}NR!=FNR && a[$1] {print $0}' b$i$j b$i1$jb > a$i$j
                        echo "b$i1$jb"
                        awk -v OFS='\t' 'NR==FNR{S[$1]=$0;next}NR>FNR{print S[$1],$8}' b$i$j a$i$j > c$i$j 
                        awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' c$i$j > z$i$j
                        echo "z$i$j"
                    fi
                else
                awk -v OFS='\t' 'NR==FNR{a[$1]=$2;}NR!=FNR && a[$1] {print $0}' b$i$j z$i1$jb > a$i$j
                echo "z$i1$jb"
                awk -v OFS='\t' 'NR==FNR{S[$1]=$0;next}NR>FNR{print S[$1],$8}' b$i$j a$i$j > c$i$j 
                awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' c$i$j > z$i$j
                echo "z$i$j"
                fi
            elif [ $((ja%2)) == 0 ]
            then
                echo "ty2 b$i$j exiting"
                let jc=($j+1)/4
                let i2=$i-2 
                if [ ! -f "z$i2$jc" ]
                then
                    if [ ! -f "b$i2$jc" ]
                    then
                        echo "b$i$j skip"
                    else
                        awk -v OFS='\t' 'NR==FNR{a[$1]=$2;}NR!=FNR && a[$1] {print $0}' b$i$j b$i2$jc > a$i$j
                        echo "b$i2$jc"
                        awk -v OFS='\t' 'NR==FNR{S[$1]=$0;next}NR>FNR{print S[$1],$8}' b$i$j a$i$j > c$i$j
                        awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' c$i$j > z$i$j
                        echo "z$i$j"
                    fi
                else
                awk -v OFS='\t' 'NR==FNR{a[$1]=$2;}NR!=FNR && a[$1] {print $0}' b$i$j z$i2$jc > a$i$j
                echo "z$i2$jc"
                awk -v OFS='\t' 'NR==FNR{S[$1]=$0;next}NR>FNR{print S[$1],$8}' b$i$j a$i$j > c$i$j
                awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' c$i$j > z$i$j
                echo "z$i$j"              
                fi
            elif [ $j == 1 ]
            then
                echo "ty3 b$i$j to z$i$j" 
                awk -v OFS='\t' '{print $0}' b$i$j > z$i$j
            else
                echo "ty4 b$i$j" #b35, b45, b49, 413
                let jz=($j-1)%4
                let i3=$i-3
                let j4=$j-4
                let i1=$i-1
                m=1
                for n in $(seq 1 $i)
                    do
                    let "m=2*m"
                    done
                    echo "$m"
                if [ $jz == 0 ]
                then
                    echo "ty4 b$i$j"
                    if [ $m == 8 ]
                    then
                        awk -v OFS='\t' 'NR==FNR{a[$1]=$2;}NR!=FNR && a[$1] {print $0}' b$i$j z$i3$j4 > a$i$j
                        awk -v OFS='\t' 'NR==FNR{S[$1]=$0;next}NR>FNR{print S[$1],$8}' b$i$j a$i$j > c$i$j
                        awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' c$i$j > z$i$j
                    elif [ $m == 16 ]
                    then
                        awk -v OFS='\t' 'NR==FNR{a[$1]=$2;}NR!=FNR && a[$1] {print $0}' b45 z11 > a45
                        awk -v OFS='\t' 'NR==FNR{S[$1]=$0;next}NR>FNR{print S[$1],$8}' b45 a45 > c45
                        awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' c45 > z45
                        awk -v OFS='\t' 'NR==FNR{a[$1]=$2;}NR!=FNR && a[$1] {print $0}' b49 z01 > a49
                        awk -v OFS='\t' 'NR==FNR{S[$1]=$0;next}NR>FNR{print S[$1],$8}' b49 a49 > c49
                        awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' c49 > z49
                        awk -v OFS='\t' 'NR==FNR{a[$1]=$2;}NR!=FNR && a[$1] {print $0}' b413 z12 > a413
                        awk -v OFS='\t' 'NR==FNR{S[$1]=$0;next}NR>FNR{print S[$1],$8}' b413 a413 > c413
                        awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7+$13, $8+$13, $9, $10}' c413 > z413
                    else
                        echo "i>=4"
                    fi

                else
                    echo "b$i$j unsure"
                fi
            fi
            done
    done
find . -name "*" -type f -size 0c | xargs -n 1 rm -f
echo "done"


## STEP 8: Rearrange {z*}. (#R Scripts)
setwd(patht)
file=list.files(getwd(),pattern="z{1}")
for(i in 1:length(file)){
    x <- read.table(file[i],sep="",header=FALSE)
    y <- x[,c(1,7,8)]
    z <- x[,c(1,9,10)]
    names(y) <- c(paste0("id"),paste0(file[i],"qs"),paste0(file[i],"qe"))
    names(z) <- c(paste0("id"),paste0(file[i],"qs"),paste0(file[i],"qe"))
    write.csv(y,paste0("format/QUERY/q",file[i],".csv"),row.names=F,col.names=T)
    write.csv(z,paste0("format/REF/r",file[i],".csv"),row.names=F,col.names=T)}
##  (i) QUERY
setwd(pathQ)
file=list.files(getwd(),pattern="qz{1}")
x <- read.csv(file[1])
for(i in 2:length(file)){
    y <- read.csv(file[i])
    z <- merge(y,x,all=TRUE,sort=TRUE)
    x <- z}
write.csv(x,"qcom.csv",row.names=F,col.names=T)
q<- read.csv("qcom.csv")
qnew <- q[1]
## NOTE: Delete invalid col data before cbind process.
qnew <- cbind(qnew, q$z41qs, q$z41qe, q$z31qs ,q$z31qe ,q$z42qs, q$z42qe, q$z21qs, q$z21qe, q$z43qs, q$z43qe, q$z32qs,q$z32qe,q$z44qs ,q$z44qe ,q$z11qs ,q$z11qe ,q$z45qs ,q$z45qe,q$z33qs ,q$z33qe ,q$z46qs ,q$z46qe ,q$z22qs,q$z22qe,q$z47qs ,q$z47qe ,q$z34qs, q$z34qe, q$z48qs ,q$z48qe ,q$z01qs ,q$z01qe ,q$z49qs ,q$z49qe,q$z35qs,q$z35qe,q$z410qs,q$z410qe ,q$z23qs ,q$z23qe ,q$z411qs ,q$z411qe ,q$z36qs,q$z36qe ,q$z412qs ,q$z412qe ,q$z12qs,q$z12qe,q$z413qs,q$z413qe,q$z37qs,q$z37qe,q$z414qs,q$z414qe,q$z24qs,q$z24qe,q$z415qs,q$z415qe,q$z38qs,q$z38qe,q$z416qs,q$z416qe)
qnew[is.na(qnew)] <- ""
setwd(patht)
write.csv(qnew,"qnew.csv",col.names=T, row.names=F)
## (ii) REF
setwd(pathR)
file=list.files(path=".",pattern="rz{1}")
x <- read.csv(file[1])
for(i in 2:length(file)){
    y <- read.csv(file[i])
    z <- merge(y,x,all=TRUE,sort=TRUE)
    x <- z}
write.csv(x,"rcom.csv",row.names=F,col.names=T)
r<- read.csv("rcom.csv")
rnew <- r[1]
## NOTE: Delete invalid col data before cbind process
rnew <- cbind(rnew,r$z41qs,r$z41qe ,r$z31qs ,r$z31qe ,r$z42qs ,r$z42qe,r$z21qs ,r$z21qe ,r$z43qs ,r$z43qe ,r$z32qs,r$z32qe,r$z44qs ,r$z44qe ,r$z11qs ,r$z11qe ,r$z45qs ,r$z45qe,r$z33qs ,r$z33qe ,r$z46qs ,r$z46qe ,r$z22qs,r$z22qe,r$z47qs ,r$z47qe ,r$z34qs ,r$z34qe,r$z48qs ,r$z48qe ,r$z01qs ,r$z01qe ,r$z49qs ,r$z49qe,r$z35qs,r$z35qe,r$z410qs,r$z410qe ,r$z23qs ,r$z23qe ,r$z411qs ,r$z411qe ,r$z36qs,r$z36qe ,r$z412qs ,r$z412qe ,r$z12qs,r$z12qe,r$z413qs,r$z413qe,r$z37qs,r$z37qe,r$z414qs,r$z414qe,r$z24qs,r$z24qe,r$z415qs,r$z415qe,r$z38qs,r$z38qe,r$z416qs,r$z416qe)
rnew[is.na(rnew)] <- ""
setwd(patht)
write.csv(rnew,"rnew.csv",col.names=T, row.names=F)


## STEP 9:  Discard blank cells in qnew.cdv and rnew.csv with VBA code, respectively. (#VBA)
## Run 'VBA.xlsm' code


## STEP 10:  Combine rnew.csv and qnew.csv into u.csv.  (#R)
setwd(patht)
ur <- read.csv("rnew.csv")
uq <- read.csv("qnew.csv")
u <- bind_cols(ur, uq)
u[is.na(u)] <- ""
write.csv(u,"u.csv",col.names=T, row.names=F)
## Note that, set 1st col name in u.csv to id.
'''------------------------------------------------------------------------------------'''


