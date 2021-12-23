#at, 12-20-21, for cvx
library(ggtree)
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)
full.loc <- "../../data/distdna/0full.csv"
rdrp.loc <- "../../data/distdna/1rdrp.csv" 
tgb1.loc <- "../../data/distdna/2tgb1.csv"
tgb2.loc <- "../../data/distdna/3tgb2.csv"
tgb3.loc <- "../../data/distdna/4tgb3.csv"
cp.loc <- "../../data/distdna/5cp.csv"
#generate graph like sdt does of frequencies
#separate by clade
#
#
#
cladesearch <- function (cladename){
  metarowname <- c()
  #fetch organism names from metadata file matching Clade column with clade name
  metarowname <- md$Organism[grep(cladename, md$Clade)]
  #change metadata organism names to match csv format
  metarowname <- gsub(" ", "_", metarowname)
  metarowname <- gsub(":", "", metarowname)
  
  #Note: Schlumbergera samples from gene specific ORF fastas have been renamed, which has been reflected in the metadata csv file.
  
  
  #Fetch the associated csv row/column number for items within list of organism names
  fullnum <<- c()
  for(i in 1:length(metarowname)){
    fullnum[i] <<- grep(metarowname[i], rownames(full))
    #print(metarowname[i])
  }
  if (anyNA(fullnum)){
    print("Warning! One or more full.csv values is NA. Please check naming in all files.")
  }
  fullcomb <- combn(sort(unique(fullnum)), 2)
  
  cpnum <<- c()
  for(i in 1:length(metarowname)){
    cpnum[i] <<- grep(metarowname[i], rownames(cp))
    #print(metarowname[i])
    #print(cpnum[i])
  }
  if (anyNA(cpnum)){
    print("Warning! One or more cp values is NA. Please check naming in all files.")
  }
  cpcomb <- combn(sort(unique(cpnum)), 2)
  
  #exceptions for missing rows/columns in rdrp file
  searchrdrp <- c("KM288843","Cactus_virus_X_KM288847.1",
                  "KM288842","KM288844","KM288845", 
                  "Cactus_virus_X__KM288847.1")
  if(any(metarowname %in%  searchrdrp)){
    print("Note: removing values because sequences did not cover the rdrp gene. Sequence removed:")
    print(metarowname[(metarowname %in%
                         searchrdrp)])
    metarowname <- metarowname[!(metarowname %in%
                                   searchrdrp)]
  }
  rdrpnum <<- c()
  for(i in 1:length(metarowname)){
    rdrpnum[i] <<- grep(metarowname[i], rownames(rdrp))
    #print(metarowname[i])
    #print(rdrpnum[i])
  }
  if (anyNA(rdrpnum)){
    print("Warning! One or more rdrp values is NA. Please check naming in all files.")
    print(rdrpnum)
  }
  rdrpcomb <- combn(sort(unique(rdrpnum)), 2)
  
  #Next, use indices to grab maximum and average pairwise distances.
  #full
  #populate vector...
  numtemp <- vector()
  for (i in 1:length(fullcomb[1,])){
    numtemp[i] <- i
  }
  #use temporary vector to get values from full genome csv
  for (i in 1:length(fullcomb[1,])){
    numtemp[i] <- full[fullcomb[1,i],fullcomb[2,i]]
  }
  #now calculate average and maximum values for these pairwise distances
  fullmax <-c(max(numtemp))
  fullavg <- c(mean(numtemp))
  #repeat for the other genes
  #rdrp
  numtemp <- vector()
  for (i in 1:length(rdrpcomb[1,])){
    numtemp[i] <- i
  }
  for (i in 1:length(rdrpcomb[1,])){
    numtemp[i] <- rdrp[rdrpcomb[1,i],rdrpcomb[2,i]]
  }
  rdrpmax <-c(max(numtemp))
  rdrpavg <- c(mean(numtemp))
  #cp
  numtemp <- vector()
  for (i in 1:length(cpcomb[1,])){
    numtemp[i] <- i
  }
  for (i in 1:length(cpcomb[1,])){
    numtemp[i] <- cp[cpcomb[1,i],cpcomb[2,i]]
  }
  cpmax <-c(max(numtemp))
  cpavg <- c(mean(numtemp))
  nums <- list("Max Values" = format(round(c(fullmax, rdrpmax, cpmax), 3), nsmall = 3), "Avg Values" = format(round(c(fullavg, rdrpavg, cpavg), 3), nsmall = 3) )
  nums
}


#Fetch values for table.

clades <- c("Cactus Virus X Variant A", " ", " ", "Cactus Virus X Variant B", " ", " ", "Zygocactus Virus X Variant B1", " ", " ", "Pitaya Virus X", " ", " ","Schlumbergera Virus X", " ", " ","Opuntia Virus X", " ", " ")
lnames <- rep(c("Full sequence", "RdRp", "Coat Protein"),6)
#matrix selection: matrix[rows, columns]
lmax <- c(cva$`Max Values`[1:3], cvb$`Max Values`[1:3], zyvx$`Max Values`[1:3] ,pvx$`Max Values`[1:3], svx$`Max Values`[1:3], opvx$`Max Values`[1:3])
lavg <- c(cva$`Avg Values`[1:3], cvb$`Avg Values`[1:3], zyvx$`Avg Values`[1:3], pvx$`Avg Values`[1:3], svx$`Avg Values`[1:3], opvx$`Avg Values`[1:3] ) 

#Store values in table, then save table as .pdf file.


sumstats <- cbind(clades, lnames, lmax, lavg)
kbl(sumstats, booktabs = T, format="html", col.names = c("Species", "Open Reading Frame (ORF)", "Maximum Pairwise Distance", "Average Pairwise Distance"))  %>% kable_styling() %>% save_kable("test.pdf")


