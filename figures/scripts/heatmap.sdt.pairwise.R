#at, 11-21-21, for cvx
library("ggplot2")
library("pheatmap")
library("dplyr")
setwd("/Users/alexa/Documents/GitHub/cactusvirusx/")
getwd()
md <- read.csv('data/name_key.csv', stringsAsFactors = FALSE)
#for nucleotides:
dat <- read.csv("data/SDT/combined.rdrp.upper.cp.lower.csv", header = TRUE)
dat$X <- gsub(pattern = "X15", "15", dat$X)
dat$X <- gsub(pattern = "X19J", "19J", dat$X)
colnames(dat) <- gsub(pattern = "X15", "15", colnames(dat))
colnames(dat) <- gsub(pattern = "X19J", "19J", colnames(dat))
#dat$X
row.names(dat) <- dat$X
dat <- subset(dat, select=-X)
#copy lower triangle to upper triangle:
#dat[upper.tri(dat)] <- t(dat)[upper.tri(t(dat))]
#annotations:
annotationcols <- subset(md, select=c(formal_tax))
rownames(annotationcols) <- md$Name_updated
#flip dat
#dat=dat[,order(ncol(dat):1)]

par(mar=c(0,0,0,2))
pheatmap::pheatmap(dat, 
                   na_col = "grey80",
         cluster_rows=F, cluster_cols = F, 
         #annotation_row = annotationcols,
         #annotation_col = annotationcols,
         #annotation_names_col = T,
         #annotation_names_row = F,
         border_color = "white",
         main = "Percentage sequence distance, upper right = RdRp, lower left = CP",
         #angle_col = 45,
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
        filename="heatmap.diag.pdf", 
        #gaps_row=9,
        # color=colors,
         #breaks=seq(range.min, range.max * 1, 0.5),
         #legend_breaks=seq(range.min, range.max, 2),
         legend_breaks = seq(0,100,10),
         #legend_labels=seq(range.min, range.max, 2),
         legend_labels = seq(0,100,10),
        # lwd=1, fontfamily=font.family, fontsize=fontsize,
         #cellwidth=cell.size, cellheight=cell.size
         )



