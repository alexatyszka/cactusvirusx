library(phytools, iqtree)
library(treeio)
library(dplyr)
# /01_trees_og_longnames/trimmed_complete_gb_and_srr-mafft.fasta.treefile
# /01_trees_og_longnames/orf1-mafft.fasta.treefile
# /01_trees_og_longnames/orf2-mafft.fasta.treefile
# /01_trees_og_longnames/orf3-mafft.fasta.treefile
# /01_trees_og_longnames/orf4-mafft.fasta.treefile
# /01_trees_og_longnames/orf5-mafft.fasta.treefile
setwd("Documents/GitHub/cactusvirusx/02_analyses/04_iqtree-output/")
zero <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/trimmed_complete_gb_and_srr-mafft.fasta.treefile"))
one <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf1-mafft.fasta.treefile"))
two <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf2-mafft.fasta.treefile"))
three <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf3-mafft.fasta.treefile"))
four <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf4-mafft.fasta.treefile"))
five <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf5-mafft.fasta.treefile"))
#remove stupid geneious names GRRR

one$tip.label <- gsub( "_-_.*", "", one$tip.label,)
two$tip.label <- gsub( "_-_.*", "", two$tip.label,)
three$tip.label <- gsub( "_-_.*", "", three$tip.label,)
four$tip.label <- gsub( "_-_.*", "", four$tip.label,)
five$tip.label <- gsub( "_-_.*", "", five$tip.label,)
#
#some sequences did not make it into the larger full-sample tree but are present in the gene trees
#four$tip.label[!four$tip.label %in% zero$tip.label]
#names_of_seqs_included <- c(one$tip.label, two$tip.label,three$tip.label,four$tip.label,five$tip.label,zero$tip.label)
#names_of_seqs_included <- data.frame(sort(unique(names_of_seqs_included)))

#uncomment these to generate a new metadata file
# metadata <- read.csv("../../01_data/combined_all_samples/metadata.csv")
# metadata$srr <- gsub( ".*_SRR", "", metadata$Name)
# metadata$srr <- gsub( "_consensus_sequence", "", metadata$srr)
# metadata$srr <- gsub( "potexvirus_-", "", metadata$srr)
# names_of_seqs_included$key <- gsub( ".*_SRR", "", names_of_seqs_included$unique.names_of_seqs_included.)
# md_for_renaming <- left_join(names_of_seqs_included, metadata, by=c("key"="srr"))
# #now the file is ready for export and some manual comparisons to the metadata file, but mostly kosher
# write.csv(md_for_renaming, "02_trees_shortnames_UIDs/metadata_for_renaming.csv")
# #this is where you can make manual edits to names that will be used for the phylogenies later on
md_for_renaming <- read.csv("02_trees_shortnames_UIDs/metadata_for_renaming_manual_edits.csv")

#now we are matching on the first column, which should match the names in the fasta files, and using the new UID or "name" column for visualization
#save fasta files with new names

tl <- data.frame(zero$tip.label)
zero_new_tip_labels <- left_join(tl, md_for_renaming, by=c("zero.tip.label" = "fasta_names"))
zero$tip.label <- zero_new_tip_labels$UID
write.tree(zero, "02_trees_shortnames_UIDs/zero.treefile")

tl <- data.frame(one$tip.label)
one_new_tip_labels <- left_join(tl, md_for_renaming, by=c("one.tip.label" = "fasta_names"))
one$tip.label <- one_new_tip_labels$UID
write.tree(one, "02_trees_shortnames_UIDs/one.treefile")

tl <- data.frame(two$tip.label)
two_new_tip_labels <- left_join(tl, md_for_renaming, by=c("two.tip.label" = "fasta_names"))
two$tip.label <- two_new_tip_labels$UID
write.tree(two, "02_trees_shortnames_UIDs/two.treefile")

tl <- data.frame(three$tip.label)
three_new_tip_labels <- left_join(tl, md_for_renaming, by=c("three.tip.label" = "fasta_names"))
three$tip.label <- three_new_tip_labels$UID
write.tree(three, "02_trees_shortnames_UIDs/three.treefile")

tl <- data.frame(four$tip.label)
four_new_tip_labels <- left_join(tl, md_for_renaming, by=c("four.tip.label" = "fasta_names"))
four$tip.label <- four_new_tip_labels$UID
write.tree(four, "02_trees_shortnames_UIDs/four.treefile")

tl <- data.frame(five$tip.label)
five_new_tip_labels <- left_join(tl, md_for_renaming, by=c("five.tip.label" = "fasta_names"))
five$tip.label <- five_new_tip_labels$UID
write.tree(five, "02_trees_shortnames_UIDs/five.treefile")

