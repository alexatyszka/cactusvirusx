#at, 1-13-22, for cvx
##this file should produce a csv file with the necessary information for plotting
library(ggtree)
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)
library(dplyr)
#just working with percent sequences for now
p.cp.loc <- "data/SDT/perc_cp_matrix.csv"
p.rdrp.loc <-"data/SDT/perc_rdrp_matrix.csv"
p.full.loc <- "data/SDT/perc_full_matrix.csv"
#load csv files 
full <- read.csv(p.full.loc, header=FALSE)
#full.names <- full$V1
#load metadata file
md <- read.csv('data/name_key.csv', stringsAsFactors = FALSE)
#remove lower diagonal of matrix if matrix is full.
#full[lower.tri(full, diag = TRUE)] <- NA

joined <- left_join(full, md, by = c("V1" = "Name_updated"))
clades.list <- unique(md$group)[2:7]
dist.csv <- data.frame(matrix(ncol=2, nrow=1))
colnames(dist.csv) <- c("Group", "Dist")
for (i in 1:length(clades.list)){
  cladename <- clades.list[i]
  selected.seqs <- c()
  #fetch organism names from metadata file matching Clade column with clade name
  selected.seqs <- joined$V1[grep(cladename, joined$group)]
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
    numtemp[i] <- full[fullcomb[2,i],fullcomb[1,i]]
  }
  numtemp
  df.to.add <- data.frame(rep(cladename, length(numtemp[numtemp!=100.001])), numtemp[numtemp!=100.001]) 
  colnames(df.to.add) <- c("Group", "Dist")
  dist.csv <<- bind_rows(dist.csv, df.to.add)

  write.csv(dist.csv, file="dist_p_full.csv")
}

