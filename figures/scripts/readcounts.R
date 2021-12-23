#at, 12-21-21, for cvx
##relative read counts and graph
library(ggtree)
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)
library(ggplot2)
readcounts.csv <- "Documents/GitHub/cactusvirusx/data/readnumbers/read_numbers_viral.csv"
readcounts <- read.csv(readcounts.csv, header=TRUE)
readcounts$rel_abund <- readcounts$viral_reads/readcounts$raw_reads
ggplot(readcounts, aes(x=sample, y=rel_abund))+
  geom_bar(stat="identity")
View(readcounts)
