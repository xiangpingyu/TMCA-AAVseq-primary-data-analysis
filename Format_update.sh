# installed.library("ggplot2")
# installed.library("rJava")
# installed.library("xlsxjars")
# installed.library("readxl")
# installed.library("dplyr")
# installed.library("tidyr")

library(ggplot2)
library(rJava)
library(xlsxjars)
library(readxl)
library(dplyr)
library(tidyr)

## STEP 1: Try to caculate the main molecule configurations of HiFi data. (#R)
# setwd("t/")
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")

## Edit the important sites of rAAV genome, e.g. ITR and promoter, refering to your reference genome.
S5 <- {5ITR_S}  
E5 <- {5ITR_E}   
M1 <- {5ITR_S + 1}
M2 <- {3ITR_S - 1}  
S3 <- {3ITR_S}     
E3 <- {3ITR_E}    
SP <- {P_S}     #promoter 5'
EP <- {P_E}     #promoter 3'


## Following are the main sub-genomic formats in our rAAV projects.

# TYPE 1: full-length
pfull <- subset(u,u[2]<= E5 & u[2]>= S5 & u[3]<= E3 & u[3]>= S3 & is.na(u[4]))
mfull <- subset(u,u[2]<= E3 & u[2]>= S3 & u[3]<= E5 & u[3]>= S5 & is.na(u[4]))

pfull2nd <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=E3 & u[3]>=S3 & u[4]<=E3 & u[4]>=S3 & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
mfull2nd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]<=E5 & u[3]>=S5 & u[4]<=E5 & u[4]>=S5 & u[5]<=E3 & u[5]>=S3 & is.na(u[6]))

# TYPE 2: snapback genome (SBG)
SBG5 <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=M2 & u[3]>=M1 & u[4]<=M2 & u[4]>=M1 & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
SBG3 <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]<=M2 & u[3]>=M1 & u[4]<=M2 & u[4]>=M1 & u[5]<=E3 & u[5]>=S3 & is.na(u[6]))
#(optional)
# SBG5_p <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=M2 & u[3]>=EP & u[4]<=M2 & u[4]>=EP & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))

SBG5nd <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E5 & u[5]>=S5 & u[6]<=E5 & u[6]>=S5 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E5 & u[9]>=S5 & is.na(u[10]))
SBG3nd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>=S3 & u[6]<=E3 & u[6]>=S3 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E3 & u[9]>=S3 & is.na(u[10]))
#(optional)
# SBG5ndp <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]>=EP & u[3]<=M2& u[4]>=EP & u[4]<=M2 & u[5]<=E5& u[5]>= S5 & u[6]<=E5& u[6]>=S5 & u[7]>=EP & u[7]<=M2 & u[8]>=EP & u[8]<=M2 & u[9]<=E5& u[9]>=S5 & is.na(u[10]))

# TYPE 3: incomplete genome (ICG)
pICG5 <- subset(u,u[2]<=E5& u[2]>=S5 & u[3]>=M1 & is.na(u[4]))
mICG5 <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E5& u[3]>=S5 & is.na(u[4]))

pICG3 <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & is.na(u[4]))
mICG3 <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E3 & u[3]>=S3  & is.na(u[4]))

ICG5nd <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E5& u[3]>=S5 & u[4]<=E5& u[4]>=S5 & u[5]<=M2 & u[5]>=M1 & is.na(u[6]))
ICG3nd  <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E3 & u[3]>=S3 & u[4]<=E3 & u[4]>=S3 & u[5]<=M2 & u[5]>=M1 & is.na(u[6]))

# TYPE 4: genome deletion mutute (GDM)
pGDM <- subset(u,u[2]<=E5& u[2]>=S5 & u[3]>=M1 & u[3]<=M2 & u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>= S3 & is.na(u[6]))
mGDM <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2 & u[4]>=M1 & u[4]<=M2 & u[5]<= E5& u[5]>= S5 & is.na(u[6]))

mGDMnd <- subset(u,u[2]<=E5& u[2]>=S5 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>=S3 & u[6]<=E3 & u[6]>=S3 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E5& u[9]>=S5 & is.na(u[10]))
pGDMnd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E5& u[5]>=S5 & u[6]<=E5 & u[6]>=S5 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E3 & u[9]>=S3 & is.na(u[10]))

## Show the subgenomic number in the rAAV population.
# dim(*)
## Show the subgenomic number
dim(pfull)
dim(mfull)
dim(pfull2nd)
dim(mfull2nd)
dim(SBG5)
# dim(SBG5_p)
dim(SBG3)
dim(SBG5nd)
# dim(SBG5ndp)
dim(SBG3nd)
dim(pICG5)
dim(mICG5)
dim(pICG3)
dim(mICG3)
dim(ICG5nd)
dim(ICG3nd)
dim(pGDM)
dim(mGDM)
dim(pGDMnd)
dim(mGDMnd) 



## (Optional): Filter subsample based on size. Try to caculate the most ratio of HiFi data. And re-run the STEP 1.
## target <- subset(ur,{filtetr setting}) 

# setwd("../work_directory/t")
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
colnames(u)[1] <- "id"

## Size filtering: <- subset(u,{size filter setting})

## 0-1000 bp
uk01 <- subset(len,len[2] <= 1000 )
uk01 <- subset(u, u$id %in% uk01$X.id)
uk01[is.na(uk01)] <- ""
write.csv(uk01,"uk01.csv",col.names=T, row.names=F)
u <- read.csv("uk01.csv")

## 1000-2000 bp
uk12 <- subset(len,len[2] <= 2000 & len[2] > 1000 )
uk12 <- subset(u, u$id %in% uk12$X.id)
uk12[is.na(uk12)] <- ""
write.csv(uk12,"uk12.csv",col.names=T, row.names=F)
u <- read.csv("uk12.csv")

## 2000-3000 bp
uk23 <- subset(len,len[2] <= 3000 & len[2] > 2000)
uk23 <- subset(u, u$id %in% uk23$X.id)
uk23[is.na(uk23)] <- ""
write.csv(uk23,"uk23.csv",col.names=T, row.names=F)
u <- read.csv("uk23.csv")

## 3000-4000 bp
uk34 <- subset(len,len[2] <= 4000 & len[2] > 3000)
uk34 <- subset(u, u$id %in% uk34$X.id)
uk34[is.na(uk34)] <- ""
write.csv(uk34,"uk34.csv",col.names=T, row.names=F)
u <- read.csv("uk34.csv")

## 4000-5000 bp
uk45 <- subset(len,len[2] <= 5000 & len[2] > 4000)
uk45 <- subset(u, u$id %in% uk45$X.id)
uk45[is.na(uk45)] <- ""
write.csv(uk45,"uk45.csv",col.names=T, row.names=F)
u <- read.csv("uk45.csv")

## 5000-6000 bp
uk56 <- subset(len,len[2] <= 6000 & len[2] > 5000)
uk56 <- subset(u, u$id %in% uk56$X.id)
uk56[is.na(uk56)] <- ""
write.csv(uk56,"uk56.csv",col.names=T, row.names=F)
u <- read.csv("uk56.csv")


