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

#Sequence: isolates of different species have less than 72% nt identity (or 80% aa identity) between their CP or Rep genes.

row.names(cp) <- gsub("_-_.*", "", cp$X)
#row.names(cp) <- gsub("_._.*", "", cp$X)
cp <- subset(cp, select=-X)
colnames(cp) <- row.names(cp)


row.names(rdrp) <- gsub("_-_.*", "", rdrp$X)
rdrp <- subset(rdrp, select=-X)
colnames(rdrp) <- row.names(rdrp)

#treedata <- ape::read.tree("02_analyses/04_iqtree-output#/01_trees_og_longnames/trimmed_complete_gb_and_srr-mafft.fasta#.treefile")
#plot(treedata, cex=0.5)
#treedata <- ape::root(treedata, interactive=T)
#plot(treedata, cex=1)
#
#plot(treedata, cex=0.5)
#cvx <- identify(treedata, nodes = TRUE, tips = TRUE,
#         labels = TRUE, quiet = FALSE)$tips
#length(cvx)
#
#
#plot(treedata, cex=0.5)
#scvx <- identify(treedata, nodes = TRUE, tips = TRUE,
#                labels = TRUE, quiet = FALSE)$tips
#length(scvx)
#
#plot(treedata, cex=0.5)
#zyvx <- identify(treedata, nodes = TRUE, tips = TRUE,
#                 labels = TRUE, quiet = FALSE)$tips
#length(zyvx)
#
#plot(treedata, cex=0.5)
#opvx <- identify(treedata, nodes = TRUE, tips = TRUE,
#                 labels = TRUE, quiet = FALSE)$tips
#length(opvx)
#
#plot(treedata, cex=0.5)
#pvx <- identify(treedata, nodes = TRUE, tips = TRUE,
#                 labels = TRUE, quiet = FALSE)$tips
#length(pvx)
#save(cvx, opvx, pvx, scvx, zyvx, file="02_analyses/05_distdna/02_output/clade_data.rds")


#####CVX support#####
m.cvx <- data.frame(matrix(nrow=length(cvx), ncol=length(cvx)))
row.names(m.cvx) <- cvx
colnames(m.cvx) <- row.names(m.cvx)
cvx.cp.subm <- data.frame()
for (sp in cvx){
  cvx.cp.subm <- rbind(cvx.cp.subm, cp[sp,])
}
cvx.cp.subm <- cvx.cp.subm[complete.cases(cvx.cp.subm),]
cvx.cp.subm <- cvx.cp.subm[,c(row.names(cvx.cp.subm))]
table(cvx.cp.subm >72)

m.cvx <- data.frame(matrix(nrow=length(cvx), ncol=length(cvx)))
row.names(m.cvx) <- cvx
colnames(m.cvx) <- row.names(m.cvx)
cvx.rdrp.subm <- data.frame()
for (sp in cvx){
  cvx.rdrp.subm <- rbind(cvx.rdrp.subm, rdrp[sp,])
}
cvx.rdrp.subm <- cvx.rdrp.subm[complete.cases(cvx.rdrp.subm),]
cvx.rdrp.subm <- cvx.rdrp.subm[,c(row.names(cvx.rdrp.subm))]
table(cvx.rdrp.subm >72)



#copy lower triangle to upper triangle:
#dat[upper.tri(dat)] <- t(dat)[upper.tri(t(dat))]
#####opvx######
m.opvx <- data.frame(matrix(nrow=length(opvx), ncol=length(opvx)))
row.names(m.opvx) <- opvx
colnames(m.opvx) <- row.names(m.opvx)
opvx.cp.subm <- data.frame()
for (sp in opvx){
  opvx.cp.subm <- rbind(opvx.cp.subm, cp[sp,])
}
opvx.cp.subm <- opvx.cp.subm[complete.cases(opvx.cp.subm),]
opvx.cp.subm <- opvx.cp.subm[,c(row.names(opvx.cp.subm))]
table(opvx.cp.subm >72)

m.opvx <- data.frame(matrix(nrow=length(opvx), ncol=length(opvx)))
row.names(m.opvx) <- opvx
colnames(m.opvx) <- row.names(m.opvx)
opvx.rdrp.subm <- data.frame()
for (sp in opvx){
  opvx.rdrp.subm <- rbind(opvx.rdrp.subm, rdrp[sp,])
}
opvx.rdrp.subm <- opvx.rdrp.subm[complete.cases(opvx.rdrp.subm),]
opvx.rdrp.subm <- opvx.rdrp.subm[,c(row.names(opvx.rdrp.subm))]
table(opvx.rdrp.subm >72)

#####pvx######
m.pvx <- data.frame(matrix(nrow=length(pvx), ncol=length(pvx)))
row.names(m.pvx) <- pvx
colnames(m.pvx) <- row.names(m.pvx)
pvx.cp.subm <- data.frame()
for (sp in pvx){
  pvx.cp.subm <- rbind(pvx.cp.subm, cp[sp,])
}
pvx.cp.subm <- pvx.cp.subm[complete.cases(pvx.cp.subm),]
pvx.cp.subm <- pvx.cp.subm[,c(row.names(pvx.cp.subm))]
table(pvx.cp.subm >72)

m.pvx <- data.frame(matrix(nrow=length(pvx), ncol=length(pvx)))
row.names(m.pvx) <- pvx
colnames(m.pvx) <- row.names(m.pvx)
pvx.rdrp.subm <- data.frame()
for (sp in pvx){
  pvx.rdrp.subm <- rbind(pvx.rdrp.subm, rdrp[sp,])
}
pvx.rdrp.subm <- pvx.rdrp.subm[complete.cases(pvx.rdrp.subm),]
pvx.rdrp.subm <- pvx.rdrp.subm[,c(row.names(pvx.rdrp.subm))]
table(pvx.rdrp.subm >72)

#####zyvx######
m.zyvx <- data.frame(matrix(nrow=length(zyvx), ncol=length(zyvx)))
row.names(m.zyvx) <- zyvx
colnames(m.zyvx) <- row.names(m.zyvx)
zyvx.cp.subm <- data.frame()
for (sp in zyvx){
  zyvx.cp.subm <- rbind(zyvx.cp.subm, cp[sp,])
}
zyvx.cp.subm <- zyvx.cp.subm[complete.cases(zyvx.cp.subm),]
zyvx.cp.subm <- zyvx.cp.subm[,c(row.names(zyvx.cp.subm))]
table(zyvx.cp.subm >72)

m.zyvx <- data.frame(matrix(nrow=length(zyvx), ncol=length(zyvx)))
row.names(m.zyvx) <- zyvx
colnames(m.zyvx) <- row.names(m.zyvx)
zyvx.rdrp.subm <- data.frame()
for (sp in zyvx){
  zyvx.rdrp.subm <- rbind(zyvx.rdrp.subm, rdrp[sp,])
}
zyvx.rdrp.subm <- zyvx.rdrp.subm[complete.cases(zyvx.rdrp.subm),]
zyvx.rdrp.subm <- zyvx.rdrp.subm[,c(row.names(zyvx.rdrp.subm))]
table(zyvx.rdrp.subm >72)


#####scvx######
m.scvx <- data.frame(matrix(nrow=length(scvx), ncol=length(scvx)))
row.names(m.scvx) <- scvx
colnames(m.scvx) <- row.names(m.scvx)
scvx.cp.subm <- data.frame()
for (sp in scvx){
  scvx.cp.subm <- rbind(scvx.cp.subm, cp[sp,])
}
scvx.cp.subm <- scvx.cp.subm[complete.cases(scvx.cp.subm),]
scvx.cp.subm <- scvx.cp.subm[,c(row.names(scvx.cp.subm))]
table(scvx.cp.subm >72)

m.scvx <- data.frame(matrix(nrow=length(scvx), ncol=length(scvx)))
row.names(m.scvx) <- scvx
colnames(m.scvx) <- row.names(m.scvx)
scvx.rdrp.subm <- data.frame()
for (sp in scvx){
  scvx.rdrp.subm <- rbind(scvx.rdrp.subm, rdrp[sp,])
}
scvx.rdrp.subm <- scvx.rdrp.subm[complete.cases(scvx.rdrp.subm),]
scvx.rdrp.subm <- scvx.rdrp.subm[,c(row.names(scvx.rdrp.subm))]
table(scvx.rdrp.subm >72)
#####annotations:####

annotationcols <- subset(annot, select=c(Formal.taxon, phyname))

annotfilt <- subset(annotationcols, Formal.taxon %in% c("Cactus virus X", 
                                                        "Opuntia virus X",
                                                        "Pitaya virus X",
                                                        "Schlumbergera virus X",
                                                        "Zygocactus virus X"))
rownames(annotfilt) <- annotfilt$phyname
annotfilt <- subset(annotfilt, select=-phyname)
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
           "#addd8e",
           "#238554",
           "black"),
         breaks = c(0,1, 72, 100, 100.1),
        cellheight = 12, cellwidth = 12,
         #gaps_row = gapsrow,
         #gaps_col = gapscol, 
         display_numbers = F,
         fontsize_number = 3,
        filename="heatmap.rawseqdist_sept13.pdf", 
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
                     "#addd8e",
                     "#238554",
                     "black"),
                   breaks = c(0,1, 72, 100, 100.1),
                   cellheight = 12, cellwidth = 12,
                   #gaps_row = gapsrow,
                   #gaps_col = gapscol, 
                   display_numbers = F,
                   fontsize_number = 3,
                   filename="heatmap.rdrp_jun25.pdf", 
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
                     "#addd8e",
                     "#238554",
                     "black"),
                   breaks = c(0,1, 72, 100, 100.1),
                   cellheight = 12, cellwidth = 12,
                   #gaps_row = gapsrow,
                   #gaps_col = gapscol, 
                   display_numbers = F,
                   fontsize_number = 3,
                   filename="heatmap.cp_jun25.pdf", 
                   #gaps_row=9,
                   # color=colors,
                   #breaks=seq(range.min, range.max * 1, 0.5),
                   #legend_breaks=seq(range.min, range.max, 2),
                   #legend_labels=seq(range.min, range.max, 2),
                   legend_labels = seq(10,100,10)
)




