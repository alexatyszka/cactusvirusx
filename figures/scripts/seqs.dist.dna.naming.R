#at, 11-21-21, for cvx
#updated 10-30-2022
#install.packages("phylotools")
library(phylotools)
library(phytools)
library(dplyr)
library(phangorn)
library(ape)
library(treeio)
library(tidyr)
getwd()
aln.loc <- "02_analyses/01_align/complete_gb_and_srr.r.aln.fasta"
aligned <- read.fasta(aln.loc)
#now run dist.dna function:

dist.matrix <- dist.dna(aligned, model = "raw", as.matrix=TRUE, pairwise.deletion=TRUE)

write.csv(dist.matrix, file="02_analyses/04_distdna/distance_fullseq.csv")

image(aligned)
