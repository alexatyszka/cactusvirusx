#######Rename tips in a newick format tree using a 1:1 csv of old names and new names
#######created by at 10-5-21
#######
translation <- read.csv('../data/name_key.csv', stringsAsFactors = FALSE)
treeloc <- "alexasandbox/iqtree_3_TGB2_names/3_TGB2_names.fasta.treefile"
treetxt <- readLines(treeloc)
translation$Organism <- gsub(" ", "_", translation$Organism)


#only run this once or gsub will freak out
for (i in 1:length(translation$Organism)){
  treetxt <- gsub(translation$Organism[i], translation$Name_updated[i], treetxt)
}
write(treetxt, file=paste(treeloc, "renamed", sep="-"))
