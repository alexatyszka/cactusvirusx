##at for cvx, oct 27 2022
getwd()
library(treeio)
library(dplyr)
library(tidytree)
library(ggtree) 
library(DECIPHER)
library(phytools)
library(ape)
library(ggplot2)
library(ggnewscale)
setwd("~/Documents/GitHub/cactusvirusx/figures/")
host.info.details <- read.csv("scripts/phylogeny_input/02_phylogeny_hosts.csv", stringsAsFactors = FALSE)
treedata <- read.iqtree(file = "../02_analyses/04_iqtree-output/01_trees_og_longnames/trimmed_complete_gb_and_srr-mafft.fasta.treefile")

to_drop <- c( "MF978248")
#"LC107517", "KU697313", "CYMRNA", "LC155795", "AY800279", "AY863024", "GQ179646", "GQ179647", "MH423501", "FJ822136", "LC107515", "JX524226", "KX196173",
plot(treedata@phylo)
treedata@phylo <- ape::root(treedata@phylo, interactive = T,resolve.root = T)
plot(treedata@phylo)

#treedata@phylo <- drop.tip(treedata@phylo, to_drop)
treedata.joined <- as.treedata(dplyr::left_join(as_tibble(treedata), as_tibble(host.info.details), by=c("label"= "Name")))
treedata.joined@phylo <- treedata@phylo

#######RECTANGULAR tree visualization:####
par(mar = c(0, 0, 0, 0))

p <- ggtree(treedata.joined, ladderize=T, layout="rectangular",
            aes( family="Helvetica"), show.legend=FALSE)+
  #virus name tip labels
  geom_tiplab(aes(label=phyname), align=F,
              size=4, offset=0.15, hjust=0) +
  #geom_tippoint(aes(subset = (Formal.taxon != ""),color=Formal.taxon), size=3)+
  #host tip labels:
  #geom_tiplab(aes( label=host, color=new), align=T, linetype=NA, size=4, offset=0.6, hjust=0)+
  geom_treescale(x=0.1, y=80,width=0.10, fontsize=4, linesize=1, offset=2.5, color='black', label='\n substitutions per site', offset.label=3)+
  theme(legend.position="none")+
  xlim(0,5)+
  geom_text2(aes(subset = !isTip, label=UFboot), hjust=-0.3)
p
#ggsave("tree_rect_ufboot.pdf",width = 50, height = 50, units = "cm")
#ggsave("tree_rect_ufboot_jun25.svg",width = 50, height = 50, units = "cm")
phost <- ggtree(treedata.joined, ladderize=T, layout="rectangular",
            aes( family="Helvetica"), show.legend=FALSE)+
  #virus name tip labels
  geom_tiplab(aes( label=host), linetype=NA,align=T, size=4, offset=1.4, hjust=0)+
  geom_tiplab(aes(label=phyname),linetype="dashed", align=T,
              size=4, offset=0.4, hjust=0) +
  geom_tippoint(aes(color=Formal.taxon), size=3)+
  #host tip labels:
  #geom_tiplab(aes( label=host, color=new), align=T, linetype=NA, size=4, offset=0.6, hjust=0)+
  geom_treescale(x=0.1, y=80,width=0.10, fontsize=4, offset=2.5, color='black', label='\n substitutions per site', offset.label=3)+
  theme(legend.position="none")+
  xlim(0,3)+
  geom_text2(aes(subset = !isTip, label=UFboot), hjust=-0.3)
  
phost  

ggsave("test_hosts.pdf",width = 35, height = 50, units = "cm")
#ggsave("tree_rect_ufboot_hosts.svg",width = 50, height = 50, units = "cm")
##heatmap
##
heatmapData <- as.data.frame(sapply(host.info.details, as.character))
rn <- as.data.frame(heatmapData[2])
rownames(heatmapData) <- rn$Name

heatmapData[c(9)] <- rep(NA, 120)


gheatmap(phost, heatmapData[c(6, 7)], colnames=T, 
         hjust=0, offset=2.9, width=0.5, colnames_angle=45)+
  xlim(0,7)
  
#scale_fill_viridis_d(option="H", name="mPTP and bPTP delimitation") #new_scale_fill()
#p2 <- p1 + new_scale_fill()
#gheatmap(p1, heatmapData[c(4)], offset=0, width=.1,
#         colnames=F,) +
 # scale_fill_viridis_d(option="C", name="Formal taxonomy")

ggsave("tree_rect_delim_info_sept10.pdf",width = 35, height = 50, units = "cm")
ggsave("tree_rect_delim_info_sept10.svg",width = 35, height = 50, units = "cm")


