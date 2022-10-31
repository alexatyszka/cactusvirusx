#######Rename tips in a newick format tree using a 1:1 csv of old names and new names
#######created by at 10-5-21
#######
translation <- read.csv('../data/name_key.csv', stringsAsFactors = FALSE)
treeloc <- "../data/iqtree_1_RdRp_names/1_RdRp_names.fasta.treefile"
treeloc <- "../data/iqtree_2_TGB1_names/2_TGB1_names.fasta.treefile"
treeloc <- "../data/iqtree_3_TGB2_names/3_TGB2_names.fasta.treefile"
treeloc <- "../data/iqtree_4_TGB3_names/4_TGB3_names.fasta.treefile"
treeloc <- "../data/iqtree_5_CP_names/5_CP_names.fasta.treefile"

treetxt <- readLines(treeloc)
translation$Organism <- gsub(" ", "_", translation$Organism)


#only run this once or gsub will freak out
for (i in 1:length(translation$Organism)){
  treetxt<- gsub(translation$Organism[i], translation$Name_updated[i], treetxt)
    print(paste(i, translation$Name_updated[i]))
    
}
write(treetxt, file=paste(treeloc))
as.phylo(read.iqtree(treeloc))$tip.label
##
