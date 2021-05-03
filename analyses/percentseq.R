library(ggtree) # tree plotting
library(RCurl) # web page loading
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)

##percent sequence identity test
setwd('/Users/alexa/Desktop/cactusvirusx/')
al.fCP <- '/Users/alexa/Desktop/cactusvirusx/data/data_v2/5_CP_trans_aln.fasta'

aligned.cvx.phydat <- read.phyDat(al.fCP, format='fasta', type='DNA')
aligned.cvx.bin <- as.DNAbin(aligned.cvx.phydat)
dist.matrixCP <- dist.dna(aligned.cvx.bin, model = "raw", as.matrix=TRUE)
write.csv(dist.matrixCP, file="distmatrixCP.csv")

