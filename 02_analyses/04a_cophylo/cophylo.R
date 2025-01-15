#install.packages("treeio")
library(phytools)
#library(iqtree)
library(treeio, gridextra)
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
"LC107515")

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

drop.zero <- ape::drop.tip(rerooted.zero, outgroup)
drop.one  <- ape::drop.tip(rerooted.one , outgroup)
drop.two  <- ape::drop.tip(rerooted.two , outgroup)
drop.three <-ape::drop.tip(rerooted.three,outgroup)
drop.four <- ape::drop.tip(rerooted.four, outgroup)
drop.five <- ape::drop.tip(rerooted.five, outgroup)
# layout(matrix(1:4, 2, 2, byrow = TRUE))
#
#
#####function####
make.cophylo.obj <- function(tree1, tree2) {
  obj<-cophylo(tree1,tree2)
  #association <- cbind(tree2$tip.label, tree2$tip.label)
  #obj <- cotangleplot(tree1, tree2, type=c("phylogram"),
  #                    use.edge.length=TRUE, tangle="tree1")
 # svg(file=pdfname,
   #   width=10, height=14)
  plot(obj,link.type="curved",link.lwd=3,link.lty="solid",
       link.col=make.transparent("blue",0.25),fsize=0.4, show.tip.label=F)
  
 # dev.off()
  # dev.off()
}
zero_one <- make.cophylo.obj(drop.zero, drop.one)

####function####
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
make.cophylo.plot(drop.zero, drop.one,   "fullxorf1_sep13.svg")
make.cophylo.plot(drop.zero, drop.two,   "fullxorf2_sep13.svg")
make.cophylo.plot(drop.zero, drop.three, "fullxorf3_sep13.svg")
make.cophylo.plot(drop.zero, drop.four,  "fullxorf4_sep13.svg")
make.cophylo.plot(drop.zero, drop.five,  "fullxorf5_sep13.svg")

##one
make.cophylo.plot(drop.one, drop.two,  "orf1xorf2_sept13.svg")
make.cophylo.plot(drop.one, drop.three,"orf1xorf3_sept13.svg")
make.cophylo.plot(drop.one, drop.four, "orf1xorf4_sept13.svg")
make.cophylo.plot(drop.one, drop.five, "orf1xorf5_sept13.svg")

##twodrop
make.cophylo.plot(drop.two, drop.three,"orf2xorf3_sept13.svg")
make.cophylo.plot(drop.two, drop.four, "orf2xorf4_sept13.svg")
make.cophylo.plot(drop.two, drop.five, "orf2xorf5_sept13.svg")

##three
make.cophylo.plot(drop.three, drop.four, "orf3xorf4__sept13.svg")
make.cophylo.plot(drop.three, drop.five, "orf3xorf5__sept13.svg")

##four
make.cophylo.plot(drop.four, drop.five, "orf4xorf5_sept13.svg")



#https://arftrhmn.net/how-to-make-cophylogeny/
t1 <-ggtree(drop.one)  %<+%  meta + geom_tiplab()
t2 <- ggtree(drop.two)  %<+%  meta + geom_tiplab()

t1
t2

d1 <- $data
d2 <- t2$data

d1$tree <-'t1'
d2$tree <-'t2'

d2$x <- max(d2$x) - d2$x + max(d1$x) +  max(d1$x)*0.3
pp <- t1 + geom_tree(data=d2)
pp 
