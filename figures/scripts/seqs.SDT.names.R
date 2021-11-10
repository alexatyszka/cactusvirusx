#install.packages("phylotools")
library(phylotools)
phyloc <- "../../data/iqtree_0_full-aln_names/0_full-aln_names.fasta.uniqueseq.phy"

phydf <- read.phylip(phyloc, clean_name = TRUE)
metadatafile <-"../../data/name_key.csv"
metadatadf <- read.csv(metadatafile, stringsAsFactors = FALSE)
metadatadf$Organism <- gsub(" ", "_", metadatadf$Organism)
#metadatadf$Organism
metadatadf$Organism <- gsub("\\.", "_", metadatadf$Organism)
metadatadf$Organism <- gsub("-", "_", metadatadf$Organism)

phydf$seq.name <- gsub("__", "_", phydf$seq.name)

newdf <- left_join(as_tibble(phydf), as_tibble(metadatadf), by=c("seq.name" = "Organism"))
View(newdf)
metadatadf$Organism
tofasta <- data.frame(newdf$Name_updated,newdf$seq.text)
names(tofasta) <- c("seq.name", "seq.text")
dat2fasta(tofasta, outfile="seqsSDTaccnames.FASTA")