#at, 12-20-21, for cvx
##this file should produce a summary statistic csv file that can be used in the manuscript
library(ggtree)
library(phangorn)
library(phytools)
library(ape)
library(DECIPHER)
library(treeio)
library(dplyr)
full.dist.dna.loc <-"../../data/distdna/full_seqs_dist_clades.csv"
  cp.dist.dna.loc <-"../../data/distdna/cp_dist_clades.csv"
  rdrp.dist.dna.loc <-"../../data/distdna/rdrp_dist_clades.csv"
full.perc.loc <-"../../data/SDT/dist_p_full.csv"
  cp.perc.loc <-"../../data/SDT/dist_p_cp.csv"
  rdrp.perc.loc <- "../../data/SDT/dist_p_rdrp.csv"

locs <- c(full.dist.dna.loc, cp.dist.dna.loc, rdrp.dist.dna.loc, 
          full.perc.loc, cp.perc.loc, rdrp.perc.loc
          )
names <- c("full.dist.dna", "cp.dist.dna", "rdrp.dist.dna",
           "full.perc", "cp.perc", "rdrp.perc")
#code taken from https://rpubs.com/CPEL/summarystats
for (i in c(1:length(locs))) {
  loaded.csv <- read.csv(locs[i])
  summary <- loaded.csv %>%
    group_by(Group) %>%
    summarize(
      mean_Dist = mean(Dist),
      max_Dist = max(Dist),
      min_Dist = min(Dist),
      n = n(),
    )
  write.csv(summary, file= paste(names[i], "_sum.csv", sep=""))
}
