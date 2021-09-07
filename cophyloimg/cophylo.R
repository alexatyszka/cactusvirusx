BiocManager::install(c("phytools","phangorn", "treeio"))
library(treeio)
tree0 <- as.phylo(read.iqtree(loc0))
tree1 <- as.phylo(read.iqtree(loc1))
tree2 <- as.phylo(read.iqtree(loc2))
tree3 <- as.phylo(read.iqtree(loc3))
tree4 <- as.phylo(read.iqtree(loc4))
tree5 <- as.phylo(read.iqtree(loc5))
#convert from S4 to phylo
#generate matrix of possibilities 0-5
treelist <- c(tree0, tree1, tree2, tree3, tree4, tree5)
treelistnames <- c("full", "rdrp", "tgb1", "tgb2", "tgb3", "cp")
toloop <- combn(c(1:6), 2, simplify=F)
for (i in 1:length(toloop)) {
  cotemp <- cophylo(treelist[toloop[[i]][1]][[1]], treelist[toloop[[i]][2]][[1]])
  pdf(file=paste0(treelistnames[toloop[[i]][1]],"_", treelistnames[toloop[[i]][2]],".pdf"),
      width=14, height=14)
  plot(cotemp, cex=0.25, link.lty="solid", link.col=make.transparent("red",0.5))
  dev.off()
  }
  
#phytools::cophylo()
#phytools:writeNexus()

 