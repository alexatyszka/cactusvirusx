install.packages("treeio")
library(phytools, iqtree)
library(treeio)
zero <- as.phylo(treeio::read.iqtree("trimmed_complete_gb_and_srr-mafft.fasta.treefile"))
one <- as.phylo(treeio::read.iqtree("orf1-mafft.fasta.treefile"))
two <- as.phylo(treeio::read.iqtree("orf2-mafft.fasta.treefile"))
three <- as.phylo(treeio::read.iqtree("orf3-mafft.fasta.treefile"))
four <- as.phylo(treeio::read.iqtree("orf4-mafft.fasta.treefile"))
five <- as.phylo(treeio::read.iqtree("orf5-mafft.fasta.treefile"))
#remove stupid geneious things
for (x in c(one, two, three, four, five)){
  print(x)
  x$tip.label <- gsub( "_-_.*", "", x$tip.label,)
}



one$tip.label <- gsub( "_-_.*", "", one$tip.label,)
two$tip.label <- gsub( "_-_.*", "", two$tip.label,)
three$tip.label <- gsub( "_-_.*", "", three$tip.label,)
four$tip.label <- gsub( "_-_.*", "", four$tip.label,)
five$tip.label <- gsub( "_-_.*", "", five$tip.label,)

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
