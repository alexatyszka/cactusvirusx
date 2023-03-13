install.packages("treeio")
library(phytools, iqtree)
library(treeio)
setwd("Documents/GitHub/cactusvirusx/02_analyses/04_iqtree-output/")
zero <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/trimmed_complete_gb_and_srr-mafft.fasta.treefile"))
one <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf1-mafft.fasta.treefile"))
two <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf2-mafft.fasta.treefile"))
three <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf3-mafft.fasta.treefile"))
four <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf4-mafft.fasta.treefile"))
five <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf5-mafft.fasta.treefile"))
md_for_renaming <- read.csv("02_trees_shortnames_UIDs/metadata_for_renaming_manual_edits.csv")

#remove gene identifiers for now:
one$tip.label <- gsub( "_-_.*", "", one$tip.label,)
two$tip.label <- gsub( "_-_.*", "", two$tip.label,)
three$tip.label <- gsub( "_-_.*", "", three$tip.label,)
four$tip.label <- gsub( "_-_.*", "", four$tip.label,)
five$tip.label <- gsub( "_-_.*", "", five$tip.label,)

#root all trees on the same place:

obj<-cophylo(zero,one)
obj
pdf(file="orf1.pdf",
    width=14, height=14)
plot(obj,link.type="curved",link.lwd=3,link.lty="solid",
     link.col=make.transparent("blue",0.25),fsize=0.8)
dev.off()
dev.off()

obj<-cophylo(zero,two)
obj
pdf(file="orf2.pdf",
    width=14, height=14)
plot(obj,link.type="curved",link.lwd=3,link.lty="solid",
     link.col=make.transparent("blue",0.25),fsize=0.8)
dev.off()
