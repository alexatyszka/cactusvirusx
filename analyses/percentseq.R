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
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/4_TGB3_nostop.fasta",
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/3_TGB2_nostop.fasta",
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/2_TGB1_nostop.fasta",
  "/Users/alexa/Desktop/cactusvirusx/data/data_v3/1_RdRp_nostop.fasta",
                "/Users/alexa/Desktop/cactusvirusx/data/data_v3/0_full-aln.fasta")


#Renaming fasta function - still needs work

md <- read.csv(metadatapath, stringsAsFactors = FALSE)

cvxrename = function(filepath) {
  tmpfile <- readChar(filepath,999999)
  for (i in (1:length(md$Name))){
    #gsub(pattern, replacement, file)
    tmpfile <- gsub(md$Name[i], md$Organism[i], tmpfile, fixed = T)
    write(tmpfile, file = "name.fasta")
  }
}

cvxrename(accesslist[1])

#Percent seq .csv production, given .fasta file.
perc.seq <- function(filepath, name) {
  aligned.cvx.phydat <- read.phyDat(filepath, format='fasta', type='DNA')
aligned.cvx.bin <- as.DNAbin(aligned.cvx.phydat)
dist.matrix <- dist.dna(aligned.cvx.bin, model = "raw", as.matrix=TRUE)

  write.csv(dist.matrix, file=name)
print(filepath)
}

for (i in (1:length(c("5_CP_perseq.csv", "4_TGB3_perseq.csv", "3_TGB2_perseq.csv", "2_TGB1_perseq.csv","1_RdRp_perseq.csv")))) {
  
}
