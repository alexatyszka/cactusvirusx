#Load libraries
library(ggtree) # tree plotting
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)


##Set up paths for file access later
setwd('/Users/alexa/Desktop/cactusvirusx/')
accesslist <- c(
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/5_CP_nostop.fasta",
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/4_TGB3.fasta",
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/3_TGB2_nostop.fasta",
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/2_TGB1.fasta",
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/1_RdRp_nostop.fasta",
                "/Users/alexa/Desktop/cactusvirusx/data/data_v3/0_full-aln.fasta")


#Renaming fasta function - still needs work
metadatapath <- "/Users/alexa/Desktop/cactusvirusx/data/data_v1/cvx_hostdata_v3.csv"
md <- read.csv(metadatapath, stringsAsFactors = FALSE)

cvxrename = function(filepath, name) {
  tmpfile <- readChar(filepath,999999)
  for (i in (1:length(md$Name))){
    #gsub(pattern, replacement, file)
    tmpfile <- gsub(md$Name[i], md$Organism[i], tmpfile, fixed = T)
  }
  tmpfile <- gsub(" ", "_", tmpfile, fixed = T)
  tmpfile <- gsub(":", "_", tmpfile, fixed = T)
  write(tmpfile, file = name)
}

#Run this renaming for all ORFs and full genome.
names <-c("5_CP_nostop_names.fasta", "4_TGB3_names.fasta", "3_TGB2_nostop_names.fasta", "2_TGB1_names.fasta","1_RdRp_nostop_names.fasta", "0_full-aln_names.fasta")
for (i in (1:length(names))) {
  cvxrename(accesslist[i], names[i])
}
#Percent seq .csv production, given .fasta file.
perc.seq <- function(filepath, name) {
  aligned.cvx.phydat <- read.phyDat(filepath, format='fasta', type='DNA')
aligned.cvx.bin <- as.DNAbin(aligned.cvx.phydat)
dist.matrix <- dist.dna(aligned.cvx.bin, model = "raw", as.matrix=TRUE)

  write.csv(dist.matrix, file=name)
print(filepath)
}
#Run this for all ORFS and full genome.
for (i in (1:length(c("5_CP_perseq.csv", "4_TGB3_perseq.csv", "3_TGB2_perseq.csv", "2_TGB1_perseq.csv","1_RdRp_perseq.csv")))) {
  
}

