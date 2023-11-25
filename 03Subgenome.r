## Process {b*}
## Load R Libraries

## Read Genomic Location 
fmt <- read.csv("raw_data/Format.csv")

S5 <- fmt$S5  #{5ITR_S}  
E5 <- fmt$E5  #{5ITR_E}   
M1 <- fmt$M1  #{5ITR_E + 1}
M2 <- fmt$M2  #{3ITR_S - 1}  
S3 <- fmt$S3  #{3ITR_S}     
E3 <- fmt$E3  #{3ITR_E}    
SP <- fmt$SP  #{P_S}, promoter 5
EP <- fmt$EP  #{P_E}, promoter 3


## Create Subgenome Function
Subgenome <- function(u){

## TYPE 1: Full particles
pfull <- subset(u,u[2]<= E5 & u[2]>= S5 & u[3]<= E3 & u[3]>= S3 & is.na(u[4]))
mfull <- subset(u,u[2]<= E3 & u[2]>= S3 & u[3]<= E5 & u[3]>= S5 & is.na(u[4]))
full_1st <- rbind(pfull,mfull)
full_1st[is.na(full_1st)] <- ""
write.csv(full_1st,"full_1st.csv",col.names=T, row.names=F)

## full_dimer
pfullnd <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=E3 & u[3]>=S3 & u[4]<=E3 & u[4]>=S3 & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
mfullnd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]<=E5 & u[3]>=S5 & u[4]<=E5 & u[4]>=S5 & u[5]<=E3 & u[5]>=S3 & is.na(u[6]))
full_2nd <- rbind(pfullnd,mfullnd)
full_2nd[is.na(full_2nd)] <- ""
write.csv(full_2nd,"full_2nd.csv",col.names=T, row.names=F)

## TYPE 2: Snapback genome (SBG)
SBG5 <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=M2 & u[3]>=M1 & u[4]<=M2 & u[4]>=M1 & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
SBG3 <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]<=M2 & u[3]>=M1 & u[4]<=M2 & u[4]>=M1 & u[5]<=E3 & u[5]>=S3 & is.na(u[6]))
SBG_1st <- rbind(SBG5,SBG3)
SBG_1st[is.na(SBG_1st)] <- ""
write.csv(SBG_1st,"SBG_1st.csv",col.names=T, row.names=F)

## (optional)
SBG5_p <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=M2 & u[3]>=EP & u[4]<=M2 & u[4]>=EP & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
SBG5_p[is.na(SBG5_p)] <- ""
write.csv(SBG5_p,"SBG5_p.csv",col.names=T, row.names=F)

##  SBG_dimer
SBG5nd <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E5 & u[5]>=S5 & u[6]<=E5 & u[6]>=S5 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E5 & u[9]>=S5 & is.na(u[10]))
SBG3nd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>=S3 & u[6]<=E3 & u[6]>=S3 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E3 & u[9]>=S3 & is.na(u[10]))
SBG_2nd <- rbind(SBG5nd,SBG3nd)
SBG_2nd[is.na(SBG_2nd)] <- ""
write.csv(SBG_2nd,"SBG_2nd.csv",col.names=T, row.names=F)

## (optional)
SBG5nd_p <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]>=EP & u[3]<=M2& u[4]>=EP & u[4]<=M2 & u[5]<=E5& u[5]>= S5 & u[6]<=E5& u[6]>=S5 & u[7]>=EP & u[7]<=M2 & u[8]>=EP & u[8]<=M2 & u[9]<=E5& u[9]>=S5 & is.na(u[10]))
SBG5nd_p[is.na(SBG5nd_p)] <- ""
write.csv(SBG5nd_p,"SBG5nd_p.csv",col.names=T, row.names=F)

## TYPE 3: Incomplete genome (ICG)
pICG5 <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]>=M1 & is.na(u[4]))
mICG5 <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E5& u[3]>=S5 & is.na(u[4]))
pICG3 <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & is.na(u[4]))
mICG3 <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E3 & u[3]>=S3  & is.na(u[4]))
ICG_1st <- rbind(pICG5,mICG5,pICG3,mICG3)
ICG_1st[is.na(ICG_1st)] <- ""
write.csv(ICG_1st,"ICG_1st.csv",col.names=T, row.names=F)

## ICG_dimer
ICG5nd <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E5& u[3]>=S5 & u[4]<=E5& u[4]>=S5 & u[5]<=M2 & u[5]>=M1 & is.na(u[6]))
ICG3nd  <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E3 & u[3]>=S3 & u[4]<=E3 & u[4]>=S3 & u[5]<=M2 & u[5]>=M1 & is.na(u[6]))
ICG_2nd <- rbind(ICG5nd,ICG3nd)
ICG_2nd[is.na(ICG_2nd)] <- ""
write.csv(ICG_2nd,"ICG_2nd.csv",col.names=T, row.names=F)

## TYPE 4: Genome deletion mutute (GDM)
pGDM <- subset(u,u[2]<=E5& u[2]>=S5 & u[3]>=M1 & u[3]<=M2 & u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>= S3 & is.na(u[6]))
mGDM <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2 & u[4]>=M1 & u[4]<=M2 & u[5]<= E5& u[5]>= S5 & is.na(u[6]))
GDM_1st <- rbind(pGDM,mGDM)
GDM_1st[is.na(GDM_1st)] <- ""
write.csv(GDM_1st,"GDM_1st.csv",col.names=T, row.names=F)

## GDM_dimer
mGDMnd <- subset(u,u[2]<=E5& u[2]>=S5 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>=S3 & u[6]<=E3 & u[6]>=S3 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E5& u[9]>=S5 & is.na(u[10]))
pGDMnd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E5& u[5]>=S5 & u[6]<=E5 & u[6]>=S5 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E3 & u[9]>=S3 & is.na(u[10]))
GDM_2nd <- rbind(pGDMnd,mGDMnd)
GDM_2nd[is.na(GDM_2nd)] <- ""
write.csv(GDM_2nd,"GDM_2nd.csv",col.names=T, row.names=F)

## Show the subgenomic counts in the rAAV population. 
full <- (dim(full_1st)+dim(full_2nd))
nfull <- full[1]
rfull <- nfull/dim(u)[1]*100

SBG <- (dim(SBG_1st)+dim(SBG_2nd))
nSBG <- SBG[1]
rSBG <- nSBG/dim(u)[1]*100

a5SBG <- (dim(SBG5)+dim(SBG5nd))
n5SBG <- a5SBG[1]
r5SBG <- n5SBG/dim(u)[1]*100

a3SBG <- (dim(SBG3)+dim(SBG3nd))
n3SBG <- a3SBG[1]
r3SBG <- n3SBG/dim(u)[1]*100

SBG5p <- (dim(SBG5_p)+dim(SBG5nd_p))
nSBG5p <- SBG5p[1]
rSBG5p <- nSBG5p/dim(u)[1]*100

ICG <- (dim(ICG_1st)+dim(ICG_2nd))
nICG <- ICG[1]
rICG <- nICG/dim(u)[1]*100

GDM <- (dim(GDM_1st)+dim(GDM_2nd))
nGDM <- GDM[1]
rGDM <- nGDM/dim(u)[1]*100

SUM <- (dim(full_1st)+dim(full_2nd)+dim(SBG_1st)+dim(SBG_2nd)+dim(ICG_1st)+dim(ICG_2nd)+dim(GDM_1st)+dim(GDM_2nd))
nSUM <- SUM[1]
rSUM <- nSUM/dim(u)[1]*100
n <- dim(u)[1]

SUM <- c(nSUM,nfull,nGDM,nICG,nSBG,n5SBG,n3SBG,nSBG5p)
RATIO <- c(rSUM,rfull,rGDM,rICG,rSBG,r5SBG,r3SBG,rSBG5p)
x = data.frame(SUM,RATIO)
namer <- basename(getwd())
colnames(x) <- c(paste0(namer,"_NUMS"),paste0(namer))
rownames(x) <- c("SUM","FULL","GDM","ICG","SBG","5SBG","3SBG","SBG5p")
write.csv(x,paste0(namer,"_list.csv"),sep="",row.names=T,col.names=T)
}

## Run Subgenome function in specific size range.
## (i) ALL Aligned Reads
u <- read.csv("export/u.csv")
len <- read.csv("export/*Flen.txt", sep="\t")
Subgenome(u)

## (ii) Subsample based on size and caculate the most ratio of HiFi data. Size filtering: target <- subset(u,{size filter setting})
# ## 0-1k bp
# setwd(patht)  
# u <- read.csv("u.csv")
# len <- read.csv("Flen.txt", sep="\t")
# setwd(pathf)
# dir.create("k01")
# setwd(path.expand("./k01"))
# k01 <- subset(len,len[2] <= 1000 )
# k01 <- subset(u, u$id %in% k01$X.id)
# k01[is.na(k01)] <- ""
# write.csv(k01,"k01.csv",col.names=T, row.names=F)
# u <- read.csv("k01.csv")
# n01 <- dim(u)
# Subgenome(u)
