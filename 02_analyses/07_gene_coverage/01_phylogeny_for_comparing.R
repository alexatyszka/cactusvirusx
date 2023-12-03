##at for cvx, Nov 29 2023
##produce phylogeny and cophylo plots for visual comparison
getwd()
setwd("~/Documents/GitHub/cactusvirusx/02_analyses/07_gene_coverage/")
library(treeio)
library(dplyr)
library(tidytree)
library(ggtree) 
library(DECIPHER)
library(phytools)
library(ape)
library(ggplot2)
library(ggnewscale)

host.info.details <- read.csv("../../figures/scripts/02_phylogeny_hosts.csv", stringsAsFactors = FALSE)
zero <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/zero.treefile"))
one <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/one.treefile"))
two <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/two.treefile"))
three <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/three.treefile"))
four <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/four.treefile"))
five <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/five.treefile"))
md_for_renaming <- read.csv("../04_iqtree-output/metadata_for_renaming_manual_edits.csv")

#treedata <- read.iqtree(file = "../../02_analyses/04_iqtree-output/01_trees_og_longnames/orf1-mafft.fasta.treefile")
#to_drop <- c("CYMRNA", "LC107517", "KU697313", "KU159093", "KT717325", "LC155795", "AY800279", "AY863024", "GQ179646", "GQ179647", "MH423501", "FJ822136", "LC107515", "JX524226", "KX196173", "MF978248")
#treedata@phylo <- drop.tip(treedata@phylo, "CYMRNA")
#treedata.joined <- as.treedata(dplyr::left_join(as_tibble(treedata), as_tibble(host.info.details), by=c("label"= "Name")))
#treedata.joined@phylo <- treedata@phylo


#root all trees on the same place:
outgroup <- c(
 # "JX524226",
 # "KX196173",
 # "MF978248",
 # "AY863024",
 # "GQ179646",
 # "GQ179647",
 # "MH423501",
 # "FJ822136",
 # "AY800279",
 # "LC155795",
 # "KT717325",
 # "KU159093",
 # "KU697313",
 # "LC107517",
  "LC107515",
  "CYMRNA")

og.zero <- findMRCA(zero, outgroup, "node")
og.one <- findMRCA(one, outgroup, "node")
og.two <- findMRCA(two, outgroup, "node")
og.three<- findMRCA(three, outgroup, "node")
og.four<- findMRCA(four, outgroup, "node")
og.five<- findMRCA(five, outgroup, "node")



#treedata <- zero
#treedata.joined <- as.treedata(dplyr::left_join(as_tibble(zero), as_tibble(md_for_renaming), by=c("label"= "UID")))
#treedata.joined@phylo <- treedata@phylo


rerooted.zero <- phytools::reroot(zero, og.zero)
rerooted.one  <- phytools::reroot(one , og.one )
rerooted.two  <- phytools::reroot(two , og.two )
rerooted.three <- phytools::reroot(three, og.three)
rerooted.four <- phytools::reroot(four, og.four)
rerooted.five <- phytools::reroot(five, og.five)
#######RECTANGULAR tree visualization:####
rectangulartree <- function(tree, filenam){
  treedata <- tree
  treedata.joined <- as.treedata(dplyr::left_join(as_tibble(tree), as_tibble(md_for_renaming), by=c("label"= "UID")))
  #treedata.joined@phylo <- treedata@phylo
  write.beast(treedata.joined, "test_full.treefile")
  par(mar = c(0, 0, 0, 0))
p <- ggtree(treedata.joined, ladderize=T, layout="rectangular",
            aes( family="Helvetica"), show.legend=T)+
  #geom_tippoint(aes(color=new), size=1) + 
#labels=c("no", "yes"))+
  #virus name tip labels
  geom_tiplab(aes(color=formal_tax), align=T,linetype="dotted",
              size=3, offset=0.05, hjust=0, bg.color="white") +
  #host tip labels:
  #geom_tiplab(aes( label=host, color=new), align=T, linetype=NA, size=4, offset=0.6, hjust=0)+
  #geom_treescale(x=0.1, y=70,width=0.10, fontsize=4, linesize=1, offset=2.5, color='black', label='\n substitutions per site', offset.label=2)+
  #theme(legend.position="none")+
  xlim(0,5)+
geom_text2(aes(subset = !isTip, label=node), hjust=-0.3)
#p
ggsave(paste(c(filenam,".pdf"), sep="", collapse=""),width = 50, height = 40, units = "cm")
}
rectangulartree(rerooted.zero, "full")
rectangulartree(rerooted.one, "rdrp")
rectangulartree(rerooted.two, "tgb1")
rectangulartree(rerooted.three, "tgb2")
rectangulartree(rerooted.four, "tgb3")
rectangulartree(rerooted.five, "cp")

##heatmap
##
heatmapData <- as.data.frame(sapply(host.info.details, as.character))
rn <- as.data.frame(heatmapData[2])
rownames(heatmapData) <- rn$Name

heatmapData[c(8)] <- rep(NA, 120)


p1 <- gheatmap(p, heatmapData[c(6, 7, 8)], colnames=F, 
         hjust=0.3, offset=0.65, width=0.2, colnames_angle=45)+
  xlim(0,1.7)+
  scale_fill_viridis_d(option="H", name="mPTP and bPTP delimitation")
p2 <- p1 + new_scale_fill()
gheatmap(p2, heatmapData[c(4)], offset=0.9, width=.1,
         colnames=F,) +
  scale_fill_viridis_d(option="C", name="Formal taxonomy")

ggsave("tree_circular_delim_info.pdf",width = 50, height = 50, units = "cm")



