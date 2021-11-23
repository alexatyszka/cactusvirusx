#at, 11-21-21, for cvx
#install.packages("phylotools")
library(phylotools)
library(dplyr)
getwd()
#phyloc <- "data/iqtree_0_full-aln_names/0_full-aln_names.fasta.uniqueseq.phy"
phyloc <- "data/iqtree_5_CP_names/5_CP_names.fasta.uniqueseq.phy"
phyloc <- "data/iqtree_1_RdRp_names/1_RdRp_names.fasta.uniqueseq.phy"

  
phydf <- read.phylip(phyloc, clean_name = TRUE)
metadatafile <-"data/name_key.csv"
metadatadf <- read.csv(metadatafile, stringsAsFactors = FALSE)
metadatadf$Organism <- gsub(" ", "_", metadatadf$Organism)
metadatadf$Organism <- gsub("\\.", "_", metadatadf$Organism)
metadatadf$Organism <- gsub("-", "_", metadatadf$Organism)
metadatadf$Organism
phydf$seq.name <- gsub("__", "_", phydf$seq.name)

joinednames <- left_join(as_tibble(phydf), as_tibble(metadatadf), by=c("seq.name" = "Organism"))
View(joinednames)
#metadatadf$Organism
tofasta <- data.frame(joinednames$Name_updated,joinednames$seq.text)
names(tofasta) <- c("seq.name", "seq.text")
dat2fasta(tofasta, outfile="seqsSDTaccnames.RDRP.FASTA")
