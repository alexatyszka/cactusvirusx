######Created by atyszka, 9-9-21

# Set path to easily enable A&B to compile this
# (There are better ways)

mypath<-"/Users/alexa/Desktop/"
#mypath<-"/Users/boris/Dropbox/PROJECTS/COMPLETED/tyszka2022/cactusvirusx/data/data_v3/"

######Packages
BiocManager::install(c("phytools","phangorn", "treeio", "ggtree"))
library(treeio)
library(ape)
library(phytools)
library(ggtree)

# Import and convert trees to S4 phylo object

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


######Tree manipulation

treelist <- c(tree0, tree1, tree2, tree3, tree4, tree5)
outgrouplist <- c("Alternanthera_mosaic_virus_GQ179647",
                   "Alternanthera_mosaic_virus_AY863024",
                  "Alternanthera_mosaic_virus_GQ179646",
                  "Alternanthera_mosaic_virus_FJ822136", 
                  "Alternanthera_mosaic_virus_MH423501", 
                  "Alternanthera_mosaic_virus_LC107515",
                  "Babaco_mosaic_virus",
                  "Senna_mosaic_virus",
                  "Papaya_mosaic_virus",
                  "Plantago_asiatica_mosaic_virus_KU159093",
                  "Plantago_asiatica_mosaic_virus_KT717325", 
                  "Plantago_asiatica_mosaic_virus_LC155795", 
                  "Nandina_mosaic_virus", 
                  "Plantago_asiatica_mosaic_virus_KU697313", 
                  "Hydrangea_ringspot_virus",
                  "Clover_yellow_mosaic_virus")
for (i in 1:length(treelist)){
  mrc <- findMRCA(treelist[[i]], tips= outgrouplist)
  treelist[[i]] <- ape::root(treelist[[i]], node= mrc)
}

treelistnames <- c("full", "rdrp", "tgb1", "tgb2", "tgb3", "cp")
toloop <- combn(c(1:6), 2, simplify=F)
for (i in 1:length(toloop)) {
  cotemp <- cophylo(treelist[toloop[[i]][1]][[1]], treelist[toloop[[i]][2]][[1]])
  pdf(file=paste0(treelistnames[toloop[[i]][1]],"_", treelistnames[toloop[[i]][2]],".pdf"),
      width=14, height=14)
  plot(cotemp, cex=0.25, link.lty="solid", link.col=make.transparent("red",0.5))
  dev.off()
  }

######Graphing
ggtree(tree1, ladderize=T, show.legend = FALSE)  +
  #aes(color=group) +
  #%<+% hostinfo+
  #scale_color_manual(values=c("black", "#BE81EF", "#00A9E7", "#00B9A5", "#3FB13A", "#B39B00", "#E67E67", "#EC6DC4"))+
  #theme(legend.position="bottom")+
  #name tip labels:
  geom_tiplab(aes(), hjust=0, offset=0, align=T, linetype = "dotted")+
  #host tip labels:
  #geom_tiplab(aes(label=host, subset = !is.na(host)), align = T, linetype = 'blank', na.rm=TRUE, offset=0.7) +
  #scale
  #geom_treescale(x=0, y=60, fontsize = 3) +
  #node labels/bootstrap labels:
  geom_text2(aes(subset = !isTip, label=node), nudge_x = -0.03, nudge_y = 0.5)+
  xlim(0,4.2)
#Save to pdf format
filename = paste("nodecheck.pdf",sep="")
ggsave(filename, width = 60, height = 40, units = "cm", limitsize = FALSE)
#phytools::cophylo()
#phytools:writeNexus()

 