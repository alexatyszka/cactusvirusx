#at, 11-22-21, for cvx
library("ggplot2")
library("pheatmap")
library(formattable)
getwd()
setwd("../..")
metadatafile <-"data/name_key.csv"
metadatadf <- read.csv(metadatafile, stringsAsFactors = FALSE)
percentprop.loc <- "data/SDT/percentageseqproportion_plt.txt"
percentprop.cp.loc <- "data/SDT/percentageseqproportion_plt.txt"
percentprop <- read.csv(percentprop.loc, header =TRUE)
colnames(percentprop) <- c("Percentage", "Number", "Proportion")
#ggplot
ggplot(percentprop, aes(x=Percentage, y=Proportion))+
  geom_vline(xintercept = 72, color="red")+
  geom_line()+
  labs(x="Percentage Nucleotide Pairwise Identity (Full Sequence)", y="Proportion of Total Identities")+
  scale_x_continuous(
    breaks = seq(0, 100, 5),
    minor_breaks = seq(1,101, 1))+
  

  theme_light()
ggsave(
  "filename.pdf",
  scale = 1,
  width = 6,
 # height = 6,
  dpi = 300,
  limitsize = TRUE,
  bg = NULL,
)
