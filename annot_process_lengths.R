setwd("..")
getwd()
library(dplyr)
annotation_stats <- read.csv("Downloads/full_annot.csv")
View(annotation_stats)
cds <- annotation_stats[annotation_stats$Type == "CDS",]
genbank_annot <- read.csv("Downloads/Annotations_genbank.csv")
sra_annot <- read.csv("Downloads/SRRs and RNA-seq extraction Annotations.csv")
cd15kd <- sra_annot[sra_annot$Name =="15 kDa protein CDS",]
cd15kd<- rbind(cd15kd, genbank_annot[genbank_annot$Name =="15 kDa protein CDS",])
cd8kd <- sra_annot[sra_annot$Name =="8 kDa protein CDS",]
cd8kd<- rbind(cd8kd, genbank_annot[genbank_annot$Name =="8 kDa protein CDS",])

#cd15kd
mean(as.integer(cd15kd$Minimum))/3
mean(as.integer(cd15kd$Maximum))/3
mean(as.integer(cd15kd$Length))/3
#8kd
mean(as.integer(cd8kd$Minimum))/3
mean(as.integer(cd8kd$Maximum))/3
mean(as.integer(cd8kd$Length))/3
