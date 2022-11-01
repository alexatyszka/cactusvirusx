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
host.info.details <- read.csv("figures/scripts/02_phylogeny_hosts.csv", stringsAsFactors = FALSE)
treedata <- read.iqtree(file = "02_analyses/02_iqtree/complete_gb_and_srr.r.aln.fasta.treefile")
treedata@phylo <- reroot(treedata@phylo, interactive = TRUE)
to_drop <- c("CYMRNA", "LC107517", "KU697313", "KU159093", "KT717325", "LC155795", "AY800279", "AY863024", "GQ179646", "GQ179647", "MH423501", "FJ822136", "LC107515", "JX524226", "KX196173", "MF978248")
treedata@phylo <- drop.tip(treedata@phylo, to_drop)
treedata.joined <- as.treedata(dplyr::left_join(as_tibble(treedata), as_tibble(host.info.details), by=c("label"= "Name")))
treedata.joined@phylo <- treedata@phylo

#######RECTANGULAR tree visualization:####
par(mar = c(0, 0, 0, 0))
p <- ggtree(treedata.joined, ladderize=T, layout="rectangular",
            aes( family="Helvetica"), show.legend=FALSE)+
  #geom_tippoint(aes(color=new), size=1) + 
  scale_color_manual(values=c("black", "red"), 
labels=c("no", "yes"))+
  #virus name tip labels
  geom_tiplab(aes(color=new), align=T,linetype="dotted",
              size=3, offset=0.05, hjust=0, bg.color="white") +
  #host tip labels:
  geom_tiplab(aes( label=host, color=new), align=T, linetype=NA, size=4, offset=0.4, hjust=0)+
  geom_treescale(x=0.1, y=70,width=0.10, fontsize=4, linesize=1, offset=2, color='black', label='\n substitutions per site', offset.label=2)+
  theme(legend.position="none")+
  xlim(0,1.2)+
  geom_text(aes(label=UFboot), hjust=-.3)
p
ggsave("tree_rect.pdf",width = 50, height = 50, units = "cm")

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



