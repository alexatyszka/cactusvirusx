#install.packages("treeio")
library(phytools, iqtree)
library(treeio)
library(phangorn)
setwd("~")
setwd("Documents/GitHub/cactusvirusx/02_analyses/07_gene_coverage//")
zero <- as.phylo(treeio::read.iqtree("01_input/zero.treefile"))
one <- as.phylo(treeio::read.iqtree("01_input/one.treefile"))
two <- as.phylo(treeio::read.iqtree("01_input/two.treefile"))
three <- as.phylo(treeio::read.iqtree("01_input/three.treefile"))
four <- as.phylo(treeio::read.iqtree("01_input/four.treefile"))
five <- as.phylo(treeio::read.iqtree("01_input/five.treefile"))
md_for_renaming <- read.csv("01_input/metadata_for_renaming_manual_edits.csv")


#root all trees on the same place:
outgroup <- c(
"JX524226",
"KX196173",
"MF978248",
"AY863024",
"GQ179646",
"GQ179647",
"MH423501",
"FJ822136",
"AY800279",
"LC155795",
"KT717325",
"KU159093",
"KU697313",
"LC107517",
"LC107515",
"CYMRNA")

og.zero <- findMRCA(zero, outgroup, "node")
og.one <- findMRCA(one, outgroup, "node")
og.two <- findMRCA(two, outgroup, "node")
og.three<- findMRCA(three, outgroup, "node")
og.four<- findMRCA(four, outgroup, "node")
og.five<- findMRCA(five, outgroup, "node")

rerooted.zero <- phytools::reroot(zero, og.zero)
rerooted.one  <- phytools::reroot(one , og.one )
rerooted.two  <- phytools::reroot(two , og.two )
rerooted.three <- phytools::reroot(three, og.three)
rerooted.four <- phytools::reroot(four, og.four)
rerooted.five <- phytools::reroot(five, og.five)



make.cophylo.plot <- function(tree1, tree2, pdfname) {
  tree1 <- drop.tip(tree1, outgroup)
  tree2 <- drop.tip(tree2, outgroup)
  obj<-cophylo(tree1,tree2)
  obj
  pdf(file=pdfname,
      width=14, height=14)
  plot(obj,link.type="curved",link.lwd=3,link.lty="solid",
       link.col=make.transparent("blue",0.25),fsize=0.8)
  dev.off()
 # dev.off()
}

###full
make.cophylo.plot(rerooted.zero, rerooted.one, "fullxorf1.pdf")
make.cophylo.plot(rerooted.zero, rerooted.two, "fullxorf2.pdf")
make.cophylo.plot(rerooted.zero, rerooted.three, "fullxorf3.pdf")
make.cophylo.plot(rerooted.zero, rerooted.four, "fullxorf4.pdf")
make.cophylo.plot(rerooted.zero, rerooted.five, "fullxorf5.pdf")

##one
make.cophylo.plot(rerooted.one, rerooted.two, "orf1xorf2.pdf")
make.cophylo.plot(rerooted.one, rerooted.three, "orf1xorf3.pdf")
make.cophylo.plot(rerooted.one, rerooted.four, "orf1xorf4.pdf")
make.cophylo.plot(rerooted.one, rerooted.five, "orf1xorf5.pdf")

##two
make.cophylo.plot(rerooted.two, rerooted.three, "orf2xorf3.pdf")
make.cophylo.plot(rerooted.two, rerooted.four, "orf2xorf4.pdf")
make.cophylo.plot(rerooted.two, rerooted.five, "orf2xorf5.pdf")

##three
make.cophylo.plot(rerooted.three, rerooted.four, "orf3xorf4.pdf")
make.cophylo.plot(rerooted.three, rerooted.five, "orf3xorf5.pdf")

##four
make.cophylo.plot(rerooted.four, rerooted.five, "orf4xorf5.pdf")

