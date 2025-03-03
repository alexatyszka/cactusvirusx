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
# treedata <- read.nexus(file = "scripts/phylogeny_input/zero_ogremoved_rooted_nwk.treefile")
# View(mrca(treedata@phylo))

OG <- 
  c(
    "AY800279",
    "AY863024",
    "CYMRNA",
    "FJ822136",
    "GQ179646",
    "GQ179647",
    "JX524226",
    "KT717325",
    "KU159093",
    "KU697313",
    "KX196173",
    "LC107515",
    "LC107517",
    "LC155795",
    "MF978248",
    "MH423501"
  )

plot(treedata@phylo)
# edgelabels()
treedata@phylo <- ape::root(treedata@phylo, interactive = F,outgroup=OG)

plot(treedata@phylo)

#treedata@phylo <- drop.tip(treedata@phylo, to_drop)
treedata.joined <- as.treedata(dplyr::left_join(as_tibble(treedata), as_tibble(host.info.details), by=c("label"= "Name")))

# write.csv(dplyr::left_join(as_tibble(host.info.details), as_tibble(treedata), by=c("Name"= "label"), na_matches = ""), "indf.csv")
          
          
treedata.joined@phylo <- treedata@phylo
plot(treedata.joined@phylo)

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
  # geom_tippoint(aes(color=Formal.taxon), size=3)+
  #virus name tip labels
  geom_tiplab(aes( label=host), linetype=NA,align=T, size=4, offset=1.2, hjust=0)+
  geom_tiplab(aes(label=phyname),linetype="dashed", align=T,
              size=4, offset=0.4, hjust=0) +
  geom_tiplab(aes(label=Formal.taxon),linetype=NA, align=T,size=4, offset=2.2, hjust=0) +

  #host tip labels:
  #geom_tiplab(aes( label=host, color=new), align=T, linetype=NA, size=4, offset=0.6, hjust=0)+
  geom_treescale(x=0.1, y=80,width=0.10, fontsize=4, offset=2.5, color='black', label='\n substitutions per site', offset.label=3)+
  theme(legend.position="none")+
  xlim(NA,10)+
  geom_text2(aes(subset = !isTip, label=UFboot), size=4, hjust=-0.3)
  
phost  

ggsave("test_hosts.pdf",width = 35, height = 50, units = "cm")
#ggsave("tree_rect_ufboot_hosts.svg",width = 50, height = 50, units = "cm")
##heatmap
##
heatmapData <- as.data.frame(sapply(host.info.details, as.character))
rn <- as.data.frame(heatmapData[2])
rownames(heatmapData) <- rn$Name

# heatmapData[c(9)] <- rep(NA, 120)
heatmapData$PSC

gheatmap(phost, heatmapData[c("PSC", "mPTP","proposedspecies")], colnames=T, 
         hjust=0, offset=2, width=0.1, colnames_angle=90)+
  xlim(0,6)
  
#scale_fill_viridis_d(option="H", name="mPTP and bPTP delimitation") #new_scale_fill()
#p2 <- p1 + new_scale_fill()
#gheatmap(p1, heatmapData[c(4)], offset=0, width=.1,
#         colnames=F,) +
 # scale_fill_viridis_d(option="C", name="Formal taxonomy")

ggsave("tree_rect_delim_info_feb5.pdf",width = 60, height = 35, units = "cm")
ggsave("tree_rect_delim_info_sept10.svg",width = 60, height = 35, units = "cm")


