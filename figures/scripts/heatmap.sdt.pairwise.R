#at, 11-21-21, for cvx
library("ggplot2")
library("pheatmap")
#read matrix from comma separated txt to matrix, then plot with ggplot

setwd("/Users/alexa/Documents/GitHub/cactusvirusx/")
getwd()
metadatafile <-"data/name_key.csv"
metadatadf <- read.csv(metadatafile, stringsAsFactors = FALSE)
dat <- read.csv("data/SDTmatrix_mat.txt", header = FALSE, fill = TRUE, col.names = c(1:95))

class(dat)
dat$X1 <- gsub(pattern = ">", "", dat$X1)
dat$X1
row.names(dat) <- dat$X1
dat <- subset(dat, select=-X1)
colnames(dat) <-row.names(dat)

annotationcols <- subset(metadatadf, select=c(group))
rownames(annotationcols) <- metadatadf$Name_updated
#flip dat
dat=dat[,order(ncol(dat):1)]

#replace NA with zero
#dat[is.na(dat)] <- 0

gapsrow <- c(15, 16, 20,46,56,75,78)

gapscol <- 94-gapsrow
#plot
pheatmap(dat, cluster_rows=F, cluster_cols=F,
         #annotation_row = annotationcols,
         annotation_col = annotationcols,
         annotation_names_col = F,
         annotation_names_row = F,
         #angle_col = 45,
         na_col = "white",
         filename = "heatmap.sdt.numbers.pdf",
         cellheight = 10, cellwidth = 10,
         gaps_row = gapsrow,
         gaps_col = gapscol,
         display_numbers = T,
         fontsize_number = 2,
         #gaps_row=9,
        # color=colors,
         #breaks=seq(range.min, range.max * 1, 0.5),
         #legend_breaks=seq(range.min, range.max, 2),
         #legend_labels=seq(range.min, range.max, 2),
         border_color=rgb(0, 0, 0,0),
        # lwd=1, fontfamily=font.family, fontsize=fontsize,
         #cellwidth=cell.size, cellheight=cell.size
         )
