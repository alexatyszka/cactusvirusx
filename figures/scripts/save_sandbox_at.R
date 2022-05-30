#created by at, 2-9-22, for cvx
#Sandbox for at, saving all items needed for tree generation and experimentation
#packages
library(treeio)
library(dplyr)
library(tidytree)
library(ggtree) 
library(DECIPHER)
library(phytools)
library(ape)
library(ggplot2)
library(ggtreeExtra)
to.drop <- c("KU159093", "LC155795", "AY800279",
             "KU697313", "KT717325",
             "FJ822136", "GQ179646", "GQ179647",
             "AY863024", "MH423501",
             "MF978248","JX524226", "LC107515","KX196173",
             "D29630.1", 
             "LC107517")
getwd()
directory <- "Documents/GitHub/cactusvirusx/"
setwd(dir = directory)
host.info.loc <-'analyses/phylo.details.csv'
host.info.details <- read.csv(host.info.loc, stringsAsFactors = FALSE)
loc0 <- "data/iqtree-output/iqtree_0_full-aln_names/0_full-aln_names.fasta.treefile"
loc1 <- "data/iqtree-output/iqtree_1_RdRp_names/1_RdRp_names.fasta.treefile"
loc2 <- "data/iqtree-output/iqtree_2_TGB1_names/2_TGB1_names.fasta.treefile"
loc3 <- "data/iqtree-output/iqtree_3_TGB2_names/3_TGB2_names.fasta.treefile"
loc4 <- "data/iqtree-output/iqtree_4_TGB3_names/4_TGB3_names.fasta.treefile"
loc5 <- "data/iqtree-output/iqtree_5_CP_names/5_CP_names.fasta.treefile"
locs <- c(loc0, loc1, loc2, loc3, loc4, loc5)
names <- c("full", "rdrp", "tgb1", "tgb2", "tgb3", "cp")
#load trees
cvx.tree.phylo.treedata <- read.iqtree(locs[1])
#root tree, outgroup can be changed:
MRCA(cvx.tree.phylo.treedata, c("LC107517", "FJ822136"))
cvx.tree.phylo.treedata@phylo <- ape::root(cvx.tree.phylo.treedata@phylo, outgroup=to.drop, resolve.root=TRUE)
is.rooted(cvx.tree.phylo.treedata@phylo)
#use dplyr to join any host data
cvx.tree.phylo.treedata.joined <- as.treedata(dplyr::left_join(as_tibble(cvx.tree.phylo.treedata), as_tibble(host.info.details), by=c("label"= "Name_updated")))
#now replace the phylo S4 object of the joined tree with that of the original. 
#for some reason, things break massively without this.
cvx.tree.phylo.treedata.joined@phylo <- cvx.tree.phylo.treedata@phylo
cvx.tree.phylo.treedata.joined@data$new[is.na(cvx.tree.phylo.treedata.joined@data$new)] <- "FALSE"

save(host.info.details, host.info.loc, locs, names, cvx.tree.phylo.treedata.joined, file = "objects.for.phylo.RData")
save.image()


