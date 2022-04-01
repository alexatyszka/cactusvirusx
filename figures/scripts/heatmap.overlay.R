##at, 2-21-22, for cvx
##this file is meant to create a heatmap overlay of the sequences with uncertain species
library("ggplot2")
library("pheatmap")
library("dplyr")
setwd("/Users/alexa/Documents/GitHub/cactusvirusx/")
getwd()
md <- read.csv('data/name_key.csv', stringsAsFactors = FALSE)
#for nucleotides:
rdrp <- read.csv("analyses/SDT/perc_rdrp_matrix.csv", header = TRUE)
cp <- read.csv("analyses/SDT/perc_cp_matrix.csv", header = TRUE)
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
overlay.and <- ((rdrp>70)&(rdrp < 74))&((cp>70)&(cp < 74))
overlay.or <- ((rdrp>70)&(rdrp < 74))|((cp>70)&(cp < 74))
overlay.controv <- (((72-rdrp)>0)&((72-cp)<0))|(((72-rdrp)<0)&((72-cp)>0))
overlay.controv.dif <- (rdrp-cp)*data.frame(overlay.controv)
overlay.and <- overlay.and*1
overlay.or <- overlay.or*1
unlisted <- unlist(overlay.controv.dif)
unlisted <- unlisted[unlisted !=0]
rdrp.species1 <- rdrp < 72
  rdrp.species2 <- rdrp == 100.001
  rdrp.species <- rdrp.species1 | rdrp.species2


rdrp.rows <- apply(rdrp.species, 1, all, na.rm = TRUE)
#NA if all values in the row are below 72 or NA
#false if all values are false = not a species by rdrp
write.csv(rdrp.rows, file = "rdrp.rows.csv")

cp.species1 <- cp < 72
cp.species2 <- cp == 100.001
cp.species <- cp.species1 | cp.species2

cp.rows <- apply(cp.species, 1, all, na.rm = TRUE)
#NA if all values in the row are below 72 or NA
#false if all values are false = not a species by rdrp
write.csv(cp.rows, file = "cp.rows.csv")
#copy lower triangle to upper triangle:
#dat[upper.tri(dat)] <- t(dat)[upper.tri(t(dat))]
#annotations:
#annotationcols <- subset(md, select=c(formal_tax))
#rownames(annotationcols) <- md$Name_updated
#flip dat
#dat=dat[,order(ncol(dat):1)]
##from https://stackoverflow.com/questions/30943167/replace-logical-values-true-false-with-numeric-1-0
par(mar=c(0,0,0,2))
pheatmap::pheatmap(overlay.and, 
                   cluster_rows=F, cluster_cols = F, 
                   #annotation_row = annotationcols,
                   #annotation_col = annotationcols,
                   #annotation_names_col = T,
                   #annotation_names_row = F,
                   border_color = "transparent",
                   #angle_col = 45,
                   na_col = "grey80",
                   main = "Heatmap displaying which sequences have 70<rdrp<74 AND 70<cp<74",
                   cellheight = 12, cellwidth = 12,
                   #gaps_row = gapsrow,
                   #gaps_col = gapscol,
                   display_numbers = F,
                   fontsize_number = 3,
                   filename="overlay.and.pdf", 
                   #gaps_row=9,
                   color = c(
                     "white",
                     "red"
                   ),
                   breaks = c(-1.5, 0.5, 1.5)
                   #breaks=seq(range.min, range.max * 1, 0.5),
                   #legend_breaks=seq(range.min, range.max, 2),
                   #legend_breaks = seq(0,100,10),
                   #legend_labels=seq(range.min, range.max, 2),
                   #legend_labels = seq(0,100,10),
                   # lwd=1, fontfamily=font.family, fontsize=fontsize,
                   #cellwidth=cell.size, cellheight=cell.size
)
par(mar=c(0,0,0,2))
pheatmap::pheatmap(overlay.or, 
                   cluster_rows=F, cluster_cols = F, 
                   #annotation_row = annotationcols,
                   #annotation_col = annotationcols,
                   #annotation_names_col = T,
                   #annotation_names_row = F,
                   border_color = "transparent",
                   #angle_col = 45,
                   na_col = "grey80",
                   main = "Heatmap displaying which sequences have 70<rdrp<74 OR 70<cp<74",
                   cellheight = 12, cellwidth = 12,
                   #gaps_row = gapsrow,
                   #gaps_col = gapscol,
                   display_numbers = F,
                   fontsize_number = 3,
                   filename="overlay.or.pdf", 
                   #gaps_row=9,
                   color = c(
                     "white",
                     "orange"
                   ),
                   breaks = c(-1.5, 0.5, 1.5)
                   #breaks=seq(range.min, range.max * 1, 0.5),
                   #legend_breaks=seq(range.min, range.max, 2),
                   #legend_breaks = seq(0,100,10),
                   #legend_labels=seq(range.min, range.max, 2),
                   #legend_labels = seq(0,100,10),
                   # lwd=1, fontfamily=font.family, fontsize=fontsize,
                   #cellwidth=cell.size, cellheight=cell.size
)
pheatmap::pheatmap(overlay.controv.dif, 
                   cluster_rows=F, cluster_cols = F, 
                   #annotation_row = annotationcols,
                   #annotation_col = annotationcols,
                   #annotation_names_col = T,
                   #annotation_names_row = F,
                   border_color = "transparent",
                   #angle_col = 45,
                   na_col = "grey80",
                   main = "Heatmap displaying which sequences display sequence percentages that are controversial, or conflicted above or below the 72% cutoff for a combination of both genes. The absolute value of the percentage difference is displayed.",
                   cellheight = 12, cellwidth = 12,
                   #gaps_row = gapsrow,
                   #gaps_col = gapscol,
                   display_numbers = T,
                   fontsize_number = 3,
                   filename="overlay.controv.pdf", 
                   #gaps_row=9,
                   color = c(
                     "white",
                     "#8c96c6",
                     "#8c6bb1"
                   ),
                   breaks = c(0, 1, 2)
                   #breaks=seq(range.min, range.max * 1, 0.5),
                   #legend_breaks=seq(range.min, range.max, 2),
                   #legend_breaks = seq(0,100,10),
                   #legend_labels=seq(range.min, range.max, 2),
                   #legend_labels = seq(0,100,10),
                   # lwd=1, fontfamily=font.family, fontsize=fontsize,
                   #cellwidth=cell.size, cellheight=cell.size
)

plot.new()
histogram(unlist(overlay.controv.dif))
controv.rows <- apply(overlay.controv, 1, any)
write.csv(controv.rows, file = "controv.csv")
