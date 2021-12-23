#at, 11-21-21, for cvx
#install.packages("phylotools")
library(phylotools)
library(dplyr)
library(phangorn)
getwd()
phyloc <- "../../data/iqtree_0_full-aln_names/0_full-aln_names.fasta.uniqueseq.phy"
phyloc <- "../../data/iqtree_1_RdRp_names/1_RdRp_names.fasta.uniqueseq.phy"
phyloc <- "../../data/iqtree_2_TGB1_names/2_TGB1_names.fasta.uniqueseq.phy"
phyloc <- "../../data/iqtree_3_TGB2_names/3_TGB2_names.fasta.uniqueseq.phy"
phyloc <- "../../data/iqtree_4_TGB3_names/4_TGB3_names.fasta.uniqueseq.phy"
phyloc <- "../../data/iqtree_5_CP_names/5_CP_names.fasta.uniqueseq.phy"
#renaming with conventions, matching organism column and sequence names:
phydf <- read.phylip(phyloc, clean_name = TRUE)
metadatafile <-"../../data/name_key.csv"
metadatadf <- read.csv(metadatafile, stringsAsFactors = FALSE)
metadatadf$Organism <- gsub(" ", "_", metadatadf$Organism)
metadatadf$Organism <- gsub("\\.", "_", metadatadf$Organism)
metadatadf$Organism <- gsub("-", "_", metadatadf$Organism)
#metadatadf$Organism
phydf$seq.name <- gsub("__", "_", phydf$seq.name)
#join names with dplyr:
joinednames <- left_join(as_tibble(phydf), as_tibble(metadatadf), by=c("seq.name" = "Organism"))
#metadatadf$Organism
tempfasta <- data.frame(joinednames$Name_updated,joinednames$seq.text)
names(tempfasta) <- c("seq.name", "seq.text")
#now run dist.dna function:
aligned <- t(sapply(strsplit(tempfasta[,2],""), tolower))
rownames(aligned) <- tempfasta[,1]
#code copied from https://stackoverflow.com/questions/21113626/how-to-use-as-dnabinape-with-dna-sequences-stored-in-a-dataframe
aligned.cvx.bin <- as.DNAbin(aligned)
dist.matrix <- dist.dna(aligned.cvx.bin, model = "raw", as.matrix=TRUE)
write.csv(dist.matrix, file="../../data/0full.csv")
write.csv(dist.matrix, file="../../data/1rdrp.csv")
write.csv(dist.matrix, file="../../data/2tgb1.csv")
write.csv(dist.matrix, file="../../data/3tgb2.csv")
write.csv(dist.matrix, file="../../data/4tgb3.csv")
write.csv(dist.matrix, file="../../data/5cp.csv")
