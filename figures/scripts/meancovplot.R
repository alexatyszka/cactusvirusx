##at, 11-22-21, for cvx
library(phylotools)
library(dplyr)
library("ggplot2")
library("pheatmap")
library(formattable)
getwd()
setwd("../..")
metadatafile <-"data/name_key.csv"
metadatadf <- read.csv(metadatafile, stringsAsFactors = FALSE)
#subset metadata
meancov <- subset(metadatadf, select=c("Name_updated", "tissue", "Mean.Coverage"))
submeancov <- meancov[!(meancov$tissue==""),]
#order by tissue type
submeancov <-submeancov[order(submeancov$tissue),]
#rename rows
row.names(submeancov) <- c()
submeancov$Mean.Coverage <- round(submeancov$Mean.Coverage)
#colnames(submeancov) <- c("Name", "Tissue Type", "Mean Coverage")

fontsize <-4
ggplot(submeancov, aes(x=Name_updated, y=Mean.Coverage)) + 
  geom_bar(stat = "identity", aes(fill=tissue)) +
  geom_text(aes(label=Mean.Coverage), size=2 ,hjust=-0.2)+  
  labs(fill = "Tissue type")+
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
      axis.ticks=element_blank(),
        axis.title.x=element_blank(),
      axis.title.y=element_blank(),
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank(),
      legend.position="bottom",
      text = element_text(size = 8),
      )+
  scale_y_continuous(expand = c(0,0), limits = c(0,180000)) + 
  coord_flip()


ggsave(
"filename.pdf",
scale = 1,
width = 5,
height = 6,
dpi = 300,
limitsize = TRUE,
bg = NULL,
)
  