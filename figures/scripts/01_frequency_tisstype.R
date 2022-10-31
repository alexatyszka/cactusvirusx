#at, oct 26 2022, for cvx
tis <- read.csv(file="supplementaryinfo/brief_for_SI_truncata_asmbs.csv")
library(ggplot2)
tis$tissue_type <- as.factor(tis$tissue_type)
levels(tis$tissue_type) <- c("Petal", "Pollen", "Style")
ggplot(tis, aes(x=tissue_type)) + 
  geom_bar(stat = "count", aes(fill=tissue_type))+
  geom_text(aes(label = ..count..), stat = "count", vjust = 1.5, colour = "white")+
  theme_grey()+
  xlab("Tissue type")+
  ylab("Count")+
  theme(legend.position="none")
  
ggsave("tistype.pdf")
