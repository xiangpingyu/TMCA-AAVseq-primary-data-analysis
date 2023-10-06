## Visualization {b*} alignments STEP 11 ~ 14

## STEP 11: Update genome format information.
## (1) Edit "format.csv", the important sites of rAAV genome, e.g. ITR and promoter, refering to your reference genome.
## (2) Place Flen.txt in format directory

## Update format data of genome template
setwd(patht)
fmt <- read.csv("format.csv")
S5 <- fmt$S5  #{5ITR_S}  
E5 <- fmt$E5  #{5ITR_E}   
M1 <- fmt$M1  #{5ITR_E + 1}
M2 <- fmt$M2  #{3ITR_S - 1}  
S3 <- fmt$S3  #{3ITR_S}     
E3 <- fmt$E3  #{3ITR_E}    
SP <- fmt$SP  #{P_S}, promoter 5
EP <- fmt$EP  #{P_E}, promoter 3


## STEP 12: Create <Subgenome> function to caculate the main molecule configurations of HiFi data. (#R)
## Note here following the main sub-genomic types of our rAAV projects.
Subgenome <- function(u){
# TYPE 1: full length
pfull <- subset(u,u[2]<= E5 & u[2]>= S5 & u[3]<= E3 & u[3]>= S3 & is.na(u[4]))
mfull <- subset(u,u[2]<= E3 & u[2]>= S3 & u[3]<= E5 & u[3]>= S5 & is.na(u[4]))
full_1st <- rbind(pfull,mfull)
full_1st[is.na(full_1st)] <- ""
write.csv(full_1st,"full_1st.csv",col.names=T, row.names=F)

pfullnd <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=E3 & u[3]>=S3 & u[4]<=E3 & u[4]>=S3 & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
mfullnd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]<=E5 & u[3]>=S5 & u[4]<=E5 & u[4]>=S5 & u[5]<=E3 & u[5]>=S3 & is.na(u[6]))
full_2nd <- rbind(pfullnd,mfullnd)
full_2nd[is.na(full_2nd)] <- ""
write.csv(full_2nd,"full_2nd.csv",col.names=T, row.names=F)

# TYPE 2: Snapback genome (SBG)<=M2 & u[3]>=EP & u[4]<=M2 & u[4]>=EP & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
#
SBG5 <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=M2 & u[3]>=M1 & u[4]<=M2 & u[4]>=M1 & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
SBG3 <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]<=M2 & u[3]>=M1 & u[4]<=M2 & u[4]>=M1 & u[5]<=E3 & u[5]>=S3 & is.na(u[6]))
SBG_1st <- rbind(SBG5,SBG3)
SBG_1st[is.na(SBG_1st)] <- ""
write.csv(SBG_1st,"SBG_1st.csv",col.names=T, row.names=F)

#(optional)
SBG5_p <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]<=M2 & u[3]>=EP & u[4]<=M2 & u[4]>=EP & u[5]<=E5 & u[5]>=S5 & is.na(u[6]))
SBG5_p[is.na(SBG5_p)] <- ""
write.csv(SBG5_p,"SBG5_p.csv",col.names=T, row.names=F)

#2nd
SBG5nd <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E5 & u[5]>=S5 & u[6]<=E5 & u[6]>=S5 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E5 & u[9]>=S5 & is.na(u[10]))
SBG3nd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>=S3 & u[6]<=E3 & u[6]>=S3 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E3 & u[9]>=S3 & is.na(u[10]))
SBG_2nd <- rbind(SBG5nd,SBG3nd)
SBG_2nd[is.na(SBG_2nd)] <- ""
write.csv(SBG_2nd,"SBG_2nd.csv",col.names=T, row.names=F)

#(optional)
SBG5nd_p <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]>=EP & u[3]<=M2& u[4]>=EP & u[4]<=M2 & u[5]<=E5& u[5]>= S5 & u[6]<=E5& u[6]>=S5 & u[7]>=EP & u[7]<=M2 & u[8]>=EP & u[8]<=M2 & u[9]<=E5& u[9]>=S5 & is.na(u[10]))
SBG5nd_p[is.na(SBG5nd_p)] <- ""
write.csv(SBG5nd_p,"SBG5nd_p.csv",col.names=T, row.names=F)

# TYPE 3: Incomplete genome (ICG)
pICG5 <- subset(u,u[2]<=E5 & u[2]>=S5 & u[3]>=M1 & is.na(u[4]))
mICG5 <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E5& u[3]>=S5 & is.na(u[4]))
pICG3 <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & is.na(u[4]))
mICG3 <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E3 & u[3]>=S3  & is.na(u[4]))
ICG_1st <- rbind(pICG5,mICG5,pICG3,mICG3)
ICG_1st[is.na(ICG_1st)] <- ""
write.csv(ICG_1st,"ICG_1st.csv",col.names=T, row.names=F)

ICG5nd <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E5& u[3]>=S5 & u[4]<=E5& u[4]>=S5 & u[5]<=M2 & u[5]>=M1 & is.na(u[6]))
ICG3nd  <- subset(u,u[2]<=M2 & u[2]>=M1 & u[3]<=E3 & u[3]>=S3 & u[4]<=E3 & u[4]>=S3 & u[5]<=M2 & u[5]>=M1 & is.na(u[6]))
ICG_2nd <- rbind(ICG5nd,ICG3nd)
ICG_2nd[is.na(ICG_2nd)] <- ""
write.csv(ICG_2nd,"ICG_2nd.csv",col.names=T, row.names=F)

# TYPE 4: Genome deletion mutute (GDM)
pGDM <- subset(u,u[2]<=E5& u[2]>=S5 & u[3]>=M1 & u[3]<=M2 & u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>= S3 & is.na(u[6]))
mGDM <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2 & u[4]>=M1 & u[4]<=M2 & u[5]<= E5& u[5]>= S5 & is.na(u[6]))
GDM_1st <- rbind(pGDM,mGDM)
GDM_1st[is.na(GDM_1st)] <- ""
write.csv(GDM_1st,"GDM_1st.csv",col.names=T, row.names=F)

mGDMnd <- subset(u,u[2]<=E5& u[2]>=S5 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E3 & u[5]>=S3 & u[6]<=E3 & u[6]>=S3 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E5& u[9]>=S5 & is.na(u[10]))
pGDMnd <- subset(u,u[2]<=E3 & u[2]>=S3 & u[3]>=M1 & u[3]<=M2& u[4]>=M1 & u[4]<=M2 & u[5]<=E5& u[5]>=S5 & u[6]<=E5 & u[6]>=S5 & u[7]>=M1 & u[7]<=M2 & u[8]>=M1 & u[8]<=M2 & u[9]<=E3 & u[9]>=S3 & is.na(u[10]))
GDM_2nd <- rbind(pGDMnd,mGDMnd)
GDM_2nd[is.na(GDM_2nd)] <- ""
write.csv(GDM_2nd,"GDM_2nd.csv",col.names=T, row.names=F)

## Show the subgenomic number in the rAAV population. 
##
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


## None SBGp
# TYPE <- c("SUM","FULL","SBG","GDM","ICG")
# SUM <- c(nSUM,nfull,nSBG,nGDM,nICG)
# RATIO <- c(rSUM,rfull,rSBG,rGDM,rICG)
# x = data.frame(SUM,RATIO)
# namer <- basename(getwd())
# colnames(x) <- c(paste0(namer,"_NUMS"),paste0(namer))
# rownames(x) <- c("SUM","FULL","SBG","GDM","ICG")
# write.csv(x,paste0(namer,"_list.csv"),sep="",row.names=T,col.names=T)

SUM <- c(nSUM,nfull,nGDM,nICG,nSBG,n5SBG,n3SBG,nSBG5p)
RATIO <- c(rSUM,rfull,rGDM,rICG,rSBG,r5SBG,r3SBG,rSBG5p)
x = data.frame(SUM,RATIO)
namer <- basename(getwd())
colnames(x) <- c(paste0(namer,"_NUMS"),paste0(namer))
rownames(x) <- c("SUM","FULL","GDM","ICG","SBG","5SBG","3SBG","SBG5p")
write.csv(x,paste0(namer,"_list.csv"),sep="",row.names=T,col.names=T)}


## STEP 13: Run Subgenome function in specific size range.
## (i) ALL Aligned Reads
# setwd(patht)
# u <- read.csv("u.csv")
# len <- read.csv("Flen.txt", sep="\t")
# Subgenome(u)

## (ii) Subsample based on size and caculate the most ratio of HiFi data. Size filtering: target <- subset(u,{size filter setting})
## 0-1000 bp
setwd(patht)  
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
setwd(pathf)
dir.create("k01")
setwd(path.expand("./k01"))
k01 <- subset(len,len[2] <= 1000 )
k01 <- subset(u, u$id %in% k01$X.id)
k01[is.na(k01)] <- ""
write.csv(k01,"k01.csv",col.names=T, row.names=F)
u <- read.csv("k01.csv")
n01 <- dim(u)
Subgenome(u)
## 1000-2000 bp
setwd(patht) 
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
setwd(pathf)
dir.create("k12")
setwd(path.expand("./k12"))
k12 <- subset(len,len[2] <= 2000 & len[2] > 1000 )
k12 <- subset(u, u$id %in% k12$X.id)
k12[is.na(k12)] <- ""
write.csv(k12,"k12.csv",col.names=T, row.names=F)
u <- read.csv("k12.csv")
n12 <- dim(u)
Subgenome(u)
## 2000-3000 bp
setwd(patht)  
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
setwd(pathf)
dir.create("k23")
setwd(path.expand("./k23"))
k23 <- subset(len,len[2] <= 3000 & len[2] > 2000)
k23 <- subset(u, u$id %in% k23$X.id)
k23[is.na(k23)] <- ""
write.csv(k23,"k23.csv",col.names=T, row.names=F)
u <- read.csv("k23.csv")
n23 <- dim(u)
Subgenome(u)
## 3000-4000 bp
setwd(patht) 
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
setwd(pathf)
dir.create("k34")
setwd(path.expand("./k34"))
k34 <- subset(len,len[2] <= 4000 & len[2] > 3000)
k34 <- subset(u, u$id %in% k34$X.id)
k34[is.na(k34)] <- ""
write.csv(k34,"k34.csv",col.names=T, row.names=F)
u <- read.csv("k34.csv")
n34 <- dim(u)
Subgenome(u)
## 4000-5000 bp
setwd(patht) 
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
setwd(pathf)
dir.create("k45")
setwd(path.expand("./k45"))
k45 <- subset(len,len[2] <= 5000 & len[2] > 4000)
k45 <- subset(u, u$id %in% k45$X.id)
k45[is.na(k45)] <- ""
write.csv(k45,"k45.csv",col.names=T, row.names=F)
u <- read.csv("k45.csv")
n45 <- dim(u)
Subgenome(u)
## 5000-6000 bp
setwd(patht)  
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
setwd(pathf)
dir.create("k56")
setwd(path.expand("./k56"))
k56 <- subset(len,len[2] <= 6000 & len[2] > 5000)
k56 <- subset(u, u$id %in% k56$X.id)
k56[is.na(k56)] <- ""
write.csv(k56,"k56.csv",col.names=T, row.names=F)
u <- read.csv("k56.csv")
n56 <- dim(u)
Subgenome(u)
## 6000-7000 bp
setwd(patht)  
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
setwd(pathf)
dir.create("k67")
setwd(path.expand("./k67"))
k67 <- subset(len,len[2] <= 7000 & len[2] > 6000)
k67 <- subset(u, u$id %in% k67$X.id)
k67[is.na(k67)] <- ""
write.csv(k67,"k67.csv",col.names=T, row.names=F)
u <- read.csv("k67.csv")
n67 <- dim(u)
Subgenome(u)
## 7000-8000 bp
setwd(patht)  
u <- read.csv("u.csv")
len <- read.csv("Flen.txt", sep="\t")
setwd(pathf)
dir.create("k78")
setwd(path.expand("./k78"))
k78 <- subset(len,len[2] <= 8000 & len[2] > 7000)
k78 <- subset(u, u$id %in% k78$X.id)
k78[is.na(k78)] <- ""
write.csv(k78,"k78.csv",col.names=T, row.names=F)
u <- read.csv("k78.csv")
n78 <- dim(u)
Subgenome(u)

## Combine klist*
setwd(pathf)
k01l <- read.csv("k01/k01_list.csv",row.names=1)
k12l <- read.csv("k12/k12_list.csv",row.names=1)
k23l <- read.csv("k23/k23_list.csv",row.names=1)
k34l <- read.csv("k34/k34_list.csv",row.names=1)
k45l <- read.csv("k45/k45_list.csv",row.names=1)
k56l <- read.csv("k56/k56_list.csv",row.names=1)
k67l <- read.csv("k67/k67_list.csv",row.names=1)
k78l <- read.csv("k78/k78_list.csv",row.names=1)
uklist <- cbind(k01l,k12l,k23l,k34l,k45l,k56l,k67l,k78l)
uklist[is.na(uklist)] <- ""
write.csv(uklist,"uklist.csv",col.names=T, row.names=T)
uklist <- read.csv("uklist.csv",row.names=1)
ukRATIO <- uklist[,seq(0,ncol(uklist),2)] 
ukRATIO[is.na(ukRATIO)] <- "0"
write.csv(ukRATIO,"ukRATIO.csv",col.names=F)
ukRATIO <- read.csv("ukRATIO.csv",row.names=1)
ukRATIO <- round(ukRATIO,digits=1)
write.csv(ukRATIO,"ukRATIO_v.csv",col.names=F)
ukRATIO <- read.csv("ukRATIO_v.csv")

## STEP 14: Generate stacked Bar & Line Chart
setwd(patho)
# files <- list.files(pattern = "AAV*")  
files <- list.files(pattern = "0*AAV*")  
files

# run plot()
plot <- function(t) {
        setwd(patho)
        setwd(paste0(getwd(),"/",t,"/t/format/"))
        ukRATIO <- read.csv("ukRATIO_v.csv")
        #full,gdm,icg,sbg
        uR <- ukRATIO[2:5,] 
        uR <- melt(uR,id="X")
        #
        SB <- ukRATIO[5,]
        SB <- melt(SB,id="X")
        #
        u5SB <- ukRATIO[6,] 
        u5SB <- melt(u5SB,id="X")
        # 
        u3SB <- ukRATIO[7,] 
        u3SB <- melt(u3SB,id="X")
        #
        uSBp <- ukRATIO[8,] 
        uSBp <- melt(uSBp,id="X")
        #
        ggplot(data=uR,aes(x=variable ,y=value)) + 
        geom_bar(stat = "identity",mapping=aes(x=variable,fill=X, position="stack"),width = 0.5) + 
        labs(x="Range/kbp",y="Ratio/%")+theme_classic() + 
        scale_fill_brewer(palette="Blues") +
        geom_point(data=SB, aes(x=variable, y=value, group=1)) + 
        geom_point(data=uSBp, aes(x=variable, y=value, group=1)) + 
        geom_line(data=SB, aes(x=variable, y=value, group=1), linetype="solid",color="black",group=1) + 
        geom_line(data=uSBp, aes(x=variable, y=value, group=1), linetype = "dashed",color="red",group=1) + 
        theme(legend.title=element_blank()) +  
        theme(panel.border = element_blank()) +
        theme(legend.position="right") + 
        theme(legend.key = element_blank()) + 
        theme(legend.background = element_blank()) + 
        geom_text(data=SB, aes(label=value, y=value+20), position=position_dodge(0.9), vjust=0, size = 6, color="black") +  
        geom_text(data=uSBp, aes(label=value, y=value+5), position=position_dodge(0.9), vjust=0, size = 6, color="red") +  
        ylim(0,100) + ggtitle(paste0(t,"_plot")) + 
        theme(plot.title = element_text(hjust = 0.5,vjust= 0.3, size = 24, face = "bold"),axis.text=element_text(size=18,face = "bold"),axis.title.x = element_text(size = 18, color = "black", face = "bold", vjust = 0.5, hjust = 0.5), axis.title.y = element_text(size = 18,color = "black", face = "bold", vjust = 0.5, hjust = 0.5),legend.text=element_text(size=16,face = "bold"),legend.key.size = unit(15, "pt") ) }

## plots lapply
windowsFonts("serif") 
setwd(patho)
plots <- lapply(files, plot) 
pl <- plot_grid(plotlist = plots,label_size = 12, nrow=2)
setwd(patho)
ggsave("plot.eps",width=25, height=10)
