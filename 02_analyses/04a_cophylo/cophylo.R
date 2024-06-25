#install.packages("treeio")
library(phytools, iqtree)
library(treeio)
setwd("~")
setwd("Documents/GitHub/cactusvirusx/02_analyses/04a_cophylo/")
zero <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/zero.treefile"))
one <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/one.treefile"))
two <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/two.treefile"))
three <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/three.treefile"))
four <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/four.treefile"))
five <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/five.treefile"))
md_for_renaming <- read.csv("../04_iqtree-output/metadata_for_renaming_manual_edits.csv")


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
  obj<-cophylo(tree1,tree2)
  #association <- cbind(tree2$tip.label, tree2$tip.label)
  #obj <- cotangleplot(tree1, tree2, type=c("phylogram"),
  #                    use.edge.length=TRUE, tangle="tree1")
  svg(file=pdfname,
      width=10, height=14)
  plot(obj,link.type="curved",link.lwd=3,link.lty="solid",
       link.col=make.transparent("blue",0.25),fsize=0.4, show.tip.label=F)

  dev.off()
 # dev.off()
}
#simple.tanglegram(tree1, tree2, tip.label, Green, tiplab = T)
###full
make.cophylo.plot(rerooted.zero, rerooted.one, "fullxorf1.svg")
make.cophylo.plot(rerooted.zero, rerooted.two, "fullxorf2.svg")
make.cophylo.plot(rerooted.zero, rerooted.three, "fullxorf3.svg")
make.cophylo.plot(rerooted.zero, rerooted.four, "fullxorf4.svg")
make.cophylo.plot(rerooted.zero, rerooted.five, "fullxorf5.svg")

##one
make.cophylo.plot(rerooted.one, rerooted.two, "orf1xorf2.svg")
make.cophylo.plot(rerooted.one, rerooted.three, "orf1xorf3.svg")
make.cophylo.plot(rerooted.one, rerooted.four, "orf1xorf4.svg")
make.cophylo.plot(rerooted.one, rerooted.five, "orf1xorf5.svg")

##two
make.cophylo.plot(rerooted.two, rerooted.three, "orf2xorf3.svg")
make.cophylo.plot(rerooted.two, rerooted.four, "orf2xorf4.svg")
make.cophylo.plot(rerooted.two, rerooted.five, "orf2xorf5.svg")

##three
make.cophylo.plot(rerooted.three, rerooted.four, "orf3xorf4.svg")
make.cophylo.plot(rerooted.three, rerooted.five, "orf3xorf5.svg")

##four
make.cophylo.plot(rerooted.four, rerooted.five, "orf4xorf5.svg")

