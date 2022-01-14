#at, 12-20-21, for cvx
##this file should produce a csv file with the necessary information for plotting
library(ggtree)
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)
library(dplyr)
full.loc <- "../../data/distdna/0full.csv"
rdrp.loc <- "../../data/distdna/1rdrp.csv" 
tgb1.loc <- "../../data/distdna/2tgb1.csv"
tgb2.loc <- "../../data/distdna/3tgb2.csv"
tgb3.loc <- "../../data/distdna/4tgb3.csv"
cp.loc <- "../../data/distdna/5cp.csv"
#load csv files 
full <- read.csv(full.loc, header=FALSE)
full.names <- full$V1
#load metadata file
md <- read.csv('../../data/name_key.csv', stringsAsFactors = FALSE)
#remove lower diagonal of matrix if matrix is full.
full[lower.tri(full, diag = TRUE)] <- NA
#add back names
full$V1 <- full.names
joined <- left_join(full, md, by = c("V1" = "Name_updated"))
clades.list <- unique(md$formal_tax)[c(2:5,7)]
dist.csv <- data.frame(matrix(ncol=2, nrow=1))
colnames(dist.csv) <- c("Group", "Dist")
for (i in 1:length(clades.list)){
  cladename <- clades.list[i]
  selected.seqs <- c()
  #fetch organism names from metadata file matching Clade column with clade name
  selected.seqs <- joined$V1[grep(cladename, joined$formal_tax)]
  #Fetch the associated csv row/column number for items within list of organism names
  fullnum <- c()
  for(i in 1:length(selected.seqs)){
    print(i)
    fullnum[i] <- grep(selected.seqs[i], full$V1)
    #print(selected.seqs[i])
  }
  fullcomb <- combn(sort(unique(fullnum)), 2)
  #populate vector...
  numtemp <- vector()
  for (i in 1:length(fullcomb[1,])){
    numtemp[i] <- i
  }
  #use temporary vector to get values from full genome csv
  for (i in 1:length(fullcomb[1,])){
    numtemp[i] <- full[fullcomb[1,i],fullcomb[2,i]]
  }
  numtemp
df.to.add <- data.frame(rep(cladename, length(numtemp[numtemp!=0])), numtemp[numtemp!=0]) 
colnames(df.to.add) <- c("Group", "Dist")
dist.csv <<- bind_rows(dist.csv, df.to.add)
 # #repeat for the other genes
 #  #rdrp
 #  numtemp <- vector()
 #  for (i in 1:length(rdrpcomb[1,])){
 #    numtemp[i] <- i
 #  }
 #  for (i in 1:length(rdrpcomb[1,])){
 #    numtemp[i] <- rdrp[rdrpcomb[1,i],rdrpcomb[2,i]]
 #  }
 # 
 #  #cp
 #  numtemp <- vector()
 #  for (i in 1:length(cpcomb[1,])){
 #    numtemp[i] <- i
 #  }
 #  for (i in 1:length(cpcomb[1,])){
 #    numtemp[i] <- cp[cpcomb[1,i],cpcomb[2,i]]
 #  }
 write.csv(dist.csv, file="dist_full_cvx_combined.csv")
}

