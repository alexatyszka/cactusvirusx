##at, 2-21-22, for cvx
##this file is meant to create a heatmap overlay of the sequences with uncertain species
library("ggplot2")
library("pheatmap")
library("dplyr")
setwd("/Users/alexa/Documents/GitHub/cactusvirusx/")
getwd()
md <- read.csv('data/name_key.csv', stringsAsFactors = FALSE)
#for nucleotides:
rdrp <- read.csv("data/SDT/perc_rdrp_matrix.csv", header = TRUE)
cp <- read.csv("data/SDT/perc_cp_matrix.csv", header = TRUE)
#dat$X <- gsub(pattern = "X15", "15", dat$X)
#dat$X <- gsub(pattern = "X19J", "19J", dat$X)
#colnames(dat) <- gsub(pattern = "X15", "15", colnames(dat))
#colnames(dat) <- gsub(pattern = "X19J", "19J", colnames(dat))
row.names(cp) <- cp$X
cp <- subset(cp, select=-X)
row.names(rdrp) <- rdrp$X
rdrp <- subset(rdrp, select=-X)
rdrp <- rdrp[rownames(cp),]
rdrp <- rdrp[,colnames(cp)]
overlay <- ((rdrp>70)&(rdrp < 74))&((cp>70)&(cp < 74))
overlayrdrp <- ((rdrp>70)&(rdrp < 74))
overlaycp <- ((cp>70)&(cp < 74))
overlayrdrp <- 1*overlayrdrp
overlaycp <- 2*overlaycp

overlay.all <- overlayrdrp + overlaycp
#uncertain rdrp = 1
#uncertain cp = 2
#uncertain rdrp and cp = 3
#copy lower triangle to upper triangle:
#dat[upper.tri(dat)] <- t(dat)[upper.tri(t(dat))]
#annotations:
#annotationcols <- subset(md, select=c(formal_tax))
#rownames(annotationcols) <- md$Name_updated
#flip dat
#dat=dat[,order(ncol(dat):1)]
##from https://stackoverflow.com/questions/30943167/replace-logical-values-true-false-with-numeric-1-0
par(mar=c(0,0,0,2))
pheatmap::pheatmap(overlay.all, 
                   cluster_rows=F, cluster_cols = F, 
                   #annotation_row = annotationcols,
                   #annotation_col = annotationcols,
                   #annotation_names_col = T,
                   #annotation_names_row = F,
                   border_color = "transparent",
                   #angle_col = 45,
                   na_col = "white",
                   main = "Heatmap intended as overlay to display uncertainty, red means rdrp is between 70 and 74% similar, orange means the same range for cp, and purple means both are between 70-74%",
                   cellheight = 12, cellwidth = 12,
                   #gaps_row = gapsrow,
                   #gaps_col = gapscol,
                   display_numbers = F,
                   fontsize_number = 3,
                   filename="heatmap.overlay.pdf", 
                   #gaps_row=9,
                   color = c(
                     "white",
                     "red",
                     "orange",
                     "purple"
                   ),
                   breaks = c(-1.5, 0.5, 1.5, 2.5, 3.5)
                   #breaks=seq(range.min, range.max * 1, 0.5),
                   #legend_breaks=seq(range.min, range.max, 2),
                   #legend_breaks = seq(0,100,10),
                   #legend_labels=seq(range.min, range.max, 2),
                   #legend_labels = seq(0,100,10),
                   # lwd=1, fontfamily=font.family, fontsize=fontsize,
                   #cellwidth=cell.size, cellheight=cell.size
)



