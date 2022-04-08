#at, 12-20-21, for cvx
##this file should produce a lot of plots regarding percent sequence similarity
library(ggtree)
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)
library(dplyr)
library(ggplot2)
full.loc <- "/data/SDT/dist_p_cp.csv"
  rdrp.loc <- "/data/distdna/rdrp_dist_clades.csv" 
cp.loc <- "data/SDT/dist_p_cp.csv"
####CP distribution####
setwd(dir = "../../")
cp.mat <- read.csv(file = "analyses/SDT/ma")
cp.mat$X <- NULL
cp.mat[upper.tri(cp.mat, diag=TRUE)] <-NA
cp.list <- data.frame(unname(unlist(cp.mat)))
data <- read.csv(cp.loc, stringsAsFactors = TRUE, header = TRUE)
#data <- read.csv(full.loc, stringsAsFactors = TRUE, header = TRUE)
#data <- read.csv(full.loc, stringsAsFactors = TRUE, header = TRUE)
ggplot(cp.list, aes(x=unname.unlist.cp.mat..))+
  theme_minimal()+
  geom_density()+
  labs(y="Density", x="Coat Protein Percentage Sequence Distance")+
  geom_vline(color="red", xintercept = 72, linetype = "longdash")+
  xlim(50, 100)+ylim(0, 0.07)
filename <- "perc_dist_cp.pdf"
ggsave(filename, height = 10, units = "cm")
###RDRP distribution####
rdrp.mat <- read.csv(file = "Documents/GitHub/cactusvirusx/data/SDT/perc_rdrp_matrix.csv")
rdrp.mat$X <- NULL
rdrp.mat[upper.tri(rdrp.mat, diag=TRUE)] <-NA
rdrp.list <- data.frame(unname(unlist(rdrp.mat)))
ggplot(rdrp.list, aes(x=unname.unlist.rdrp.mat..))+
  theme_minimal()+
  geom_hist()+
  labs(y="Density", x="RdRp Percentage Sequence Distance")+
  geom_vline(color="red", xintercept = 72, linetype = "longdash")+
  xlim(50, 100)+ylim(0, 0.07)
filename <- "perc_dist_rdrp.pdf"
ggsave(filename, height = 10, units = "cm")

data <- read.csv(cp.loc, stringsAsFactors = TRUE, header = TRUE)
#data <- read.csv(full.loc, stringsAsFactors = TRUE, header = TRUE)
#data <- read.csv(full.loc, stringsAsFactors = TRUE, header = TRUE)
ggplot(cp.list, aes(x=unname.unlist.cp.mat..))+
  theme_minimal()+
  geom_density()+
  labs(y="Density", x="Coat Protein Percentage Sequence Distance")+
  geom_vline(color="red", xintercept = 72, linetype = "longdash")
filename <- "perc_dist_cp.pdf"
ggsave(filename, height = 10, units = "cm")

#plot with bars:
ggplot(cp.list, aes(y=Dist, x=Group, fill=Group))+
  scale_color_manual(name="Group", values=c("#0072B2", "#00A9E7", "#00B9A5", "#3FB13A", "#B39B00", "#E67E67", "#EC6DC4"))+
  geom_point(aes(color=Group), shape=95, alpha=0.1, size=22)+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, hjust=1),
        panel.grid.major.x  = element_blank(),
  )+
  labs(y="Calculated Sequence Distances", x="")
filename = "dist_cvx_bars.pdf"
ggsave(filename, height = 20, units = "cm")

#plot with bars:
ggplot(cp.list, aes(y=Dist, x=Group, fill=Group))+
  scale_color_manual(name="Group", values=c("#0072B2", "#00A9E7", "#00B9A5", "#3FB13A", "#B39B00", "#E67E67", "#EC6DC4"))+
  geom_point(aes(color=Group), shape=95, alpha=0.1, size=22)+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, hjust=1),
        panel.grid.major.x  = element_blank(),
        )+
  labs(y="Calculated Sequence Distances", x="")
filename = "dist_cvx_bars.pdf"
ggsave(filename, height = 20, units = "cm")
#violin plot:
ggplot(full.data, aes(y=Dist, x=Group, color=Group))+
  geom_violin()+
    scale_color_manual(name="Group", values=c("#00A9E7", "#00B9A5", "#3FB13A", "#B39B00", "#E67E67", "#EC6DC4", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#a6cee3","#1f78b4","#b2df8a","#33a02c"))+

  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, hjust=1),
        panel.grid.major.x  = element_blank(),
  )+
  labs(y="Calculated Sequence Distances", x="")
filename = "dist_cvx_combined_violin.pdf"
ggsave(filename, height = 20, units = "cm")
#scatter plot:
ggplot(full.data, aes(y=Dist, x=Group))+
  scale_color_manual(name="Group", values=c("#00A9E7", "#00B9A5", "#3FB13A", "#B39B00", "#E67E67", "#EC6DC4", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#a6cee3","#1f78b4","#b2df8a","#33a02c"))+
  geom_point(position = "jitter", alpha=0.5, aes(color=Group))+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, hjust=1),
        panel.grid.major.x  = element_blank(),
  )+
  labs(y="Calculated Sequence Distances", x="")
filename = "dist_cvx_combined_points.pdf"
ggsave(filename, height = 20, units = "cm")

