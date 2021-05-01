library(ggtree) # tree plotting
library(RCurl) # web page loading
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)

##percent sequence identity test
setwd('/Users/alexa/Desktop/cactusvirusx/')
al.f <- '/Users/alexa/Desktop/cactusvirusx/data/genbank_kr_consensus_extraction_al_trimmed.fasta'

aligned.cvx.phydat <- read.phyDat(al.f, format='fasta', type='DNA')
aligned.cvx.bin <- as.DNAbin(aligned.cvx.phydat)
dist.matrix <- dist.dna(aligned.cvx.bin, model = "raw", as.matrix=TRUE)
