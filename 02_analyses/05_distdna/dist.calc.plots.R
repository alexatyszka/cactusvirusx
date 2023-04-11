#at, 12-20-21, for cvx
##this file should produce a csv file with the necessary information for plotting
library(ggtree)
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)
library(dplyr)
library(ggplot2)
full.loc <- "../../data/distdna/full_seqs_dist_clades.csv"
  rdrp.loc <- "../../data/distdna/rdrp_dist_clades.csv" 
cp.loc <- "../../data/distdna/cp_dist_clades.csv"
full.data <- read.csv("../../data/distdna/dist_clades_full_cvx_grouped.csv", stringsAsFactors = TRUE, header = TRUE)
#plot with bars:
ggplot(full.data, aes(y=Dist, x=Group, fill=Group))+
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

