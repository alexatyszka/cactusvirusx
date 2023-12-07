#at, 11-26-23, for cvx
#install.packages("phylotools")
library(phylotools)
library(phytools)
library(dplyr)
library(phangorn)
library(ape)
library(treeio)
library(tidyr)
getwd()
setwd(dir = "~/Documents/GitHub/cactusvirusx/")
aln.loc <- "02_analyses/05_distdna/01_input/trimmed_complete_gb_and_srr-mafft.fasta"
aligned <- read.fasta(aln.loc)
aligned_cp <- read.fasta("02_analyses/05_distdna/01_input/orf5-mafft.fasta")
aligned_rdrp <- read.fasta("02_analyses/05_distdna/01_input/orf1-mafft.fasta")
#now run dist.dna function:

indel <- dist.dna(aligned, model = "indel", as.matrix=TRUE, pairwise.deletion=TRUE)

write.csv(indel, file="02_analyses/05_distdna/02_output/distance_fullseq_indel.csv")

raw <- dist.dna(aligned, model = "raw", as.matrix=TRUE, pairwise.deletion=TRUE)

write.csv(raw, file="02_analyses/05_distdna/02_output/distance_fullseq_raw.csv")
raw_to_percent <- (1-raw)*100
write.csv(raw_to_percent, file="02_analyses/05_distdna/02_output/distance_fullseq_perc.csv")

###rdrdp
indel.rdrp <- dist.dna(aligned_rdrp, model = "indel", as.matrix=TRUE, pairwise.deletion=TRUE)
write.csv(indel.rdrp, file="02_analyses/05_distdna/02_output/distance_rdrp_indel.csv")
raw.rdrp <- dist.dna(aligned_rdrp, model = "raw", as.matrix=TRUE, pairwise.deletion=TRUE)
write.csv(raw.rdrp, file="02_analyses/05_distdna/02_output/distance_rdrp_raw.csv")
raw_to_percent.rdrp <- (1-raw.rdrp)*100
write.csv(raw_to_percent.rdrp, file="02_analyses/05_distdna/02_output/distance_rdrp_perc.csv")


#cp
indel.cp <- dist.dna(aligned_cp, model = "indel", as.matrix=TRUE, pairwise.deletion=TRUE)
write.csv(indel.cp, file="02_analyses/05_distdna/02_output/distance_cp_indel.csv")
raw.cp <- dist.dna(aligned_cp, model = "raw", as.matrix=TRUE, pairwise.deletion=TRUE)
write.csv(raw.cp, file="02_analyses/05_distdna/02_output/distance_cp_raw.csv")
raw_to_percent.cp <- (1-raw.cp)*100
write.csv(raw_to_percent.cp, file="02_analyses/05_distdna/02_output/distance_cp_perc.csv")

