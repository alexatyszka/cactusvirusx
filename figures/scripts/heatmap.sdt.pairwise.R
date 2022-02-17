#at, 11-21-21, for cvx
library("ggplot2")
library("pheatmap")
library("dplyr")
BiocManager::install("ComplexHeatmap")
setwd("/Users/alexa/Documents/GitHub/cactusvirusx/")
getwd()
metadatafile <-"data/name_key.csv"
metadatadf <- read.csv(metadatafile, stringsAsFactors = FALSE)
dat <- read.csv("data/SDT/perc_rdrp_matrix.csv", header = TRUE)
md <- read.csv('data/name_key.csv', stringsAsFactors = FALSE)
#turn on for ordering
#joined <- left_join(dat, md, by = c("X" = "Name_updated"))
#joined <- arrange(joined, group, Name)
dat$X <- gsub(pattern = "X15", "15", dat$X)
dat$X <- gsub(pattern = "X19J", "19J", dat$X)
colnames(dat) <- gsub(pattern = "X15", "15", colnames(dat))
colnames(dat) <- gsub(pattern = "X19J", "19J", colnames(dat))
#dat$X
row.names(dat) <- dat$X
dat <- subset(dat, select=-X)
#dat <- dat[joined$X, ]
#dat <- dat[ ,rownames(dat)]
dat <- subset(dat, select=-NA.)
dat <- subset(dat, select=-NA..1)


#copy lower triangle to upper triangle:
#dat[upper.tri(dat)] <- t(dat)[upper.tri(t(dat))]
#delete upper triangle:
#dat[upper.tri(dat)] <- NA
#write.csv(dat, "perc_cp_matrix.csv")
annotationcols <- subset(md, select=c(formal_tax))
rownames(annotationcols) <- md$Name_updated
#flip dat
#dat=dat[,order(ncol(dat):1)]
#order by groupings
dat <- data.matrix(dat)
par(mar=c(0,0,0,2))
pheatmap::pheatmap(dat, 
         cluster_rows=F, cluster_cols = F, 
         annotation_row = annotationcols,
         annotation_col = annotationcols,
         #annotation_names_col = T,
         #annotation_names_row = F,
         border_color = "white",
         #angle_col = 45,
         color = c("#f7fcb9", "#addd8e", "#31a354"),
         breaks = c(0, 67, 72, 100),
         na_col = "white",
        cellheight = 12, cellwidth = 12,
         #gaps_row = gapsrow,
         #gaps_col = gapscol,
         display_numbers = T,
         fontsize_number = 3,
        filename="heatmap.num.rdrp.pdf", 
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



