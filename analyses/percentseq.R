#Install libraries
library(ggtree) # tree plotting
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)


##Set up paths for file access later
setwd('/Users/alexa/Desktop/cactusvirusx/')
accesslist <- c("/Users/alexa/Desktop/cactusvirusx/data/data_v3/5_CP.fasta",
                "/Users/alexa/Desktop/cactusvirusx/data/data_v3/4_TGB3.fasta",
                "/Users/alexa/Desktop/cactusvirusx/data/data_v3/3_TGB2.fasta",
                "/Users/alexa/Desktop/cactusvirusx/data/data_v3/2_TGB1.fasta",
                "/Users/alexa/Desktop/cactusvirusx/data/data_v3/1_RdRp.fasta",
                "/Users/alexa/Desktop/cactusvirusx/data/data_v3/0_full-aln.fasta")
al.fCP <- '/Users/alexa/Desktop/cactusvirusx/data/data_v3/5_CP.fasta'


#Renaming fasta function - still needs work
cvxrename <- function(filepath, metadatapath) {
  md <- read.csv(metadatapath, stringsAsFactors = FALSE)
  tmpfile <- readChar(filepath,999999)
  for (i in (1:length(md$Name))){
    #print(i)
    print (md$Name[i])
    print (md$Organism[i])
    #gsub(pattern, replacement, file)
    
    tmpfile <<-  gsub(md$Name[i], md$Organism[i], tmpfile, fixed = T)
    
  }
  write(tmpfile, file = "Test1.fasta")
 
}



mdpath <- '/Users/alexa/Desktop/cactusvirusx/data/data_v1/cvx_hostdata_v3.csv'
testfasta <- accesslist[1]
cvxrename(testfasta, mdpath)

#Percent seq .csv production, given .fasta file.
choose.node <- function(filepath) {
  
}
#aligned.cvx.phydat <- read.phyDat(al.fCP, format='fasta', type='DNA')
#aligned.cvx.bin <- as.DNAbin(aligned.cvx.phydat)
#dist.matrixCP <- dist.dna(aligned.cvx.bin, model = "raw", as.matrix=TRUE)
#write.csv(dist.matrixCP, file="distmatrixCP.csv")
