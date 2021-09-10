BiocManager::install(c("phytools","phangorn", "treeio"))
library(treeio)
mypath<-"/Users/alexa/Desktop/"
#mypath<-"/Users/boris/Dropbox/PROJECTS/COMPLETED/tyszka2022/cactusvirusx/data/data_v3/"
loc0 <- "iqtree_0_full-aln_names/0_full-aln_names.fasta.treefile"
loc1 <- "iqtree_1_RdRp_names/1_RdRp_names.fasta.treefile"
loc2 <- "iqtree_2_TGB1_names/2_TGB1_names.fasta.treefile"
loc3 <- "/Users/alexa/Desktop/cactusvirusx/data/data_v3/iqtree_3_TGB2_names/3_TGB2_names.fasta.treefile"
loc4 <- "iqtree_4_TGB3_names/4_TGB3_names.fasta.treefile"
loc5 <- "iqtree_5_CP_names/5_CP_names.fasta.treefile"
tree0 <- as.phylo(read.iqtree(paste0(mypath,loc0)))
tree1 <- as.phylo(read.iqtree(paste0(mypath,loc1)))
tree2 <- as.phylo(read.iqtree(paste0(mypath,loc2)))
tree3 <- as.phylo(read.iqtree(paste0(mypath,loc3)))
tree4 <- as.phylo(read.iqtree(paste0(mypath,loc4)))
tree5 <- as.phylo(read.iqtree(paste0(mypath,loc5)))
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

 