#at, 11-21-21, for cvx
library("ggplot2")
library("pheatmap")
library("dplyr")
setwd("/Users/alexa/Documents/GitHub/cactusvirusx/")
getwd()
dat <- read.csv('02_analyses/05_distdna/02_output/distance_fullseq_perc.csv', stringsAsFactors = FALSE)
cp <- read.csv('02_analyses/05_distdna/02_output/distance_cp_perc.csv', stringsAsFactors = FALSE)
rdrp <- read.csv('02_analyses/05_distdna/02_output/distance_rdrp_perc.csv', stringsAsFactors = FALSE)

annot <-read.csv("figures/scripts/phylogeny_input/02_phylogeny_hosts.csv") 

row.names(dat) <- dat$X
dat <- subset(dat, select=-X)



row.names(cp) <- gsub("_-_CP_CDS", "", cp$X)
cp <- subset(cp, select=-X)


row.names(rdrp) <- gsub("_-_.*", "", rdrp$X)
rdrp <- subset(rdrp, select=-X)


#copy lower triangle to upper triangle:
#dat[upper.tri(dat)] <- t(dat)[upper.tri(t(dat))]
#####annotations:####

annotationcols <- subset(annot, select=c(Formal.taxon, Name))

annotfilt <- subset(annotationcols, Formal.taxon %in% c("Cactus virus X", 
                                                        "Mytcor virus 1",
                                                        "Opuntia virus X",
                                                        "Pitaya virus X",
                                                        "Schlumbergera virus X",
                                                        "Zygocactus virus X"))
rownames(annotfilt) <- annotfilt$Name
annotfilt <- subset(annotfilt, select=-Name)




#flip dat
#dat=dat[,order(ncol(dat):1)]



par(mar=c(0,0,0,2))
pheatmap::pheatmap(dat, na_col = "grey80",
         cluster_rows=T, cluster_cols = T, 
         annotation_col = annotfilt,
         annotation_row = annotfilt,
         annotation_names_col = T,
         annotation_names_row = T,
         treeheight_row = 40,
         treeheight_col = 40,
         border_color = "white",
         main = "",
         color = c(
           "white",
           "#ffffe5",
           "#f7fcb9",
           "#d9f0a3",
           "#addd8e",
           "#78c679",
           "#41ab5d",
           "#238554",
           "black"),
         breaks = c(0, 69, 70, 71, 72, 73, 74, 75, 100, 100.1),
        cellheight = 12, cellwidth = 12,
         #gaps_row = gapsrow,
         #gaps_col = gapscol, 
         display_numbers = T,
         fontsize_number = 3,
        filename="heatmap.rawseqdist.pdf", 
        #gaps_row=9,
        # color=colors,
         #breaks=seq(range.min, range.max * 1, 0.5),
         #legend_breaks=seq(range.min, range.max, 2),
         #legend_labels=seq(range.min, range.max, 2),
         legend_labels = seq(10,100,10)
         )

########RDRP###########

par(mar=c(0,0,0,2))
pheatmap::pheatmap(rdrp, na_col = "grey80",
                   cluster_rows=T, cluster_cols = T, 
                   annotation_col = annotfilt,
                   annotation_row = annotfilt,
                   annotation_names_col = T,
                   annotation_names_row = T,
                   treeheight_row = 40,
                   treeheight_col = 40,
                   border_color = "white",
                   main = "",
                   color = c(
                     "white",
                     "#ffffe5",
                     "#f7fcb9",
                     "#d9f0a3",
                     "#addd8e",
                     "#78c679",
                     "#41ab5d",
                     "#238554",
                     "black"),
                   breaks = c(0, 69, 70, 71, 72, 73, 74, 75, 100, 100.1),
                   cellheight = 12, cellwidth = 12,
                   #gaps_row = gapsrow,
                   #gaps_col = gapscol, 
                   display_numbers = T,
                   fontsize_number = 3,
                   filename="heatmap.rdrp.pdf", 
                   #gaps_row=9,
                   # color=colors,
                   #breaks=seq(range.min, range.max * 1, 0.5),
                   #legend_breaks=seq(range.min, range.max, 2),
                   #legend_labels=seq(range.min, range.max, 2),
                   legend_labels = seq(10,100,10)
)




########CP##########
########

par(mar=c(0,0,0,2))
pheatmap::pheatmap(cp, na_col = "grey80",
                   cluster_rows=T, cluster_cols = T, 
                   annotation_col = annotfilt,
                   annotation_row = annotfilt,
                   annotation_names_col = T,
                   annotation_names_row = T,
                   treeheight_row = 40,
                   treeheight_col = 40,
                   border_color = "white",
                   main = "",
                   color = c(
                     "white",
                     "#ffffe5",
                     "#f7fcb9",
                     "#d9f0a3",
                     "#addd8e",
                     "#78c679",
                     "#41ab5d",
                     "#238554",
                     "black"),
                   breaks = c(0, 69, 70, 71, 72, 73, 74, 75, 100, 100.1),
                   cellheight = 12, cellwidth = 12,
                   #gaps_row = gapsrow,
                   #gaps_col = gapscol, 
                   display_numbers = T,
                   fontsize_number = 3,
                   filename="heatmap.cp.pdf", 
                   #gaps_row=9,
                   # color=colors,
                   #breaks=seq(range.min, range.max * 1, 0.5),
                   #legend_breaks=seq(range.min, range.max, 2),
                   #legend_labels=seq(range.min, range.max, 2),
                   legend_labels = seq(10,100,10)
)




