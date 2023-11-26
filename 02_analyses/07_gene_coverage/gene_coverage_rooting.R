library(phytools, iqtree)
library(treeio)
library(dplyr)
setwd("~")
setwd("Documents/GitHub/cactusvirusx/02_analyses/07_gene_coverage//")
zero <- as.phylo(treeio::read.iqtree("zero.treefile"))
one <- as.phylo(treeio::read.iqtree("one.treefile"))
two <- as.phylo(treeio::read.iqtree("two.treefile"))
three <- as.phylo(treeio::read.iqtree("three.treefile")) 
  four <- as.phylo(treeio::read.iqtree("four.treefile"))
five <- as.phylo(treeio::read.iqtree("five.treefile"))

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
