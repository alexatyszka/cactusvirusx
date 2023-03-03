library(phytools, iqtree)
library(treeio)
# /01_trees_og_longnames/trimmed_complete_gb_and_srr-mafft.fasta.treefile
# /01_trees_og_longnames/orf1-mafft.fasta.treefile
# /01_trees_og_longnames/orf2-mafft.fasta.treefile
# /01_trees_og_longnames/orf3-mafft.fasta.treefile
# /01_trees_og_longnames/orf4-mafft.fasta.treefile
# /01_trees_og_longnames/orf5-mafft.fasta.treefile
#setwd("Documents/GitHub/cactusvirusx/02_analyses/04_iqtree-output/")
zero <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/trimmed_complete_gb_and_srr-mafft.fasta.treefile"))
one <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf1-mafft.fasta.treefile"))
two <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf2-mafft.fasta.treefile"))
three <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf3-mafft.fasta.treefile"))
four <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf4-mafft.fasta.treefile"))
five <- as.phylo(treeio::read.iqtree("01_trees_og_longnames/orf5-mafft.fasta.treefile"))
#remove stupid geneious names GRRR
for (x in c(one, two, three, four, five)){
  print(x)
  x$tip.label <- gsub( "_-_.*", "", x$tip.label,)
}



one$tip.label <- gsub( "_-_.*", "", one$tip.label,)
two$tip.label <- gsub( "_-_.*", "", two$tip.label,)
three$tip.label <- gsub( "_-_.*", "", three$tip.label,)
four$tip.label <- gsub( "_-_.*", "", four$tip.label,)
five$tip.label <- gsub( "_-_.*", "", five$tip.label,)
