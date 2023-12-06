setwd("~/Documents/GitHub/cactusvirusx/02_analyses/07_gene_coverage/")
library(treeio)
library(dplyr)
library(tidytree)
library(ggtree) 
library(DECIPHER)
library(phytools)
library(ape)
library(ggplot2)
library(ggnewscale)

zero <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/zero.treefile"))
one <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/one.treefile"))
two <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/two.treefile"))
three <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/three.treefile"))
four <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/four.treefile"))
five <- as.phylo(treeio::read.iqtree("../04_iqtree-output/02_trees_shortnames_UIDs/five.treefile"))


#root all trees on the same place:
outgroup <- c(
   "JX524226",
   "KX196173",
   "MF978248",
   "AY863024",
   "GQ179646",
   "GQ179647",
   "MH423501",
   "FJ822136",
   "AY800279",
   "LC155795",
   "KT717325",
   "KU159093",
   "KU697313",
   "LC107517",
  "LC107515",
  "CYMRNA")

og.zero <- findMRCA(zero, outgroup, "node")
og.one <- findMRCA(one, outgroup, "node")
og.two <- findMRCA(two, outgroup, "node")
og.three<- findMRCA(three, outgroup, "node")
og.four<- findMRCA(four, outgroup, "node")
og.five<- findMRCA(five, outgroup, "node")



rerooted.zero <- phytools::reroot(zero, og.zero)
rerooted.one  <- phytools::reroot(one , og.one )
rerooted.two  <- phytools::reroot(two , og.two )
rerooted.three <- phytools::reroot(three, og.three)
rerooted.four <- phytools::reroot(four, og.four)
rerooted.five <- phytools::reroot(five, og.five)

plot(rerooted.zero)


OPVX.og <- findMRCA(rerooted.zero, c("AY366209","KU854931","KY348771"), "node")
OPVX<- extract.clade(rerooted.zero, node=OPVX.og, root.edge = 0, collapse.singles = FALSE)
plot(OPVX)
edgelabels(OPVX$edge.length, bg="black", col="white", font=2)

plot(rerooted.zero)

CVX.og <- findMRCA(rerooted.zero, c("AF308158"                          
                                    ,"SRR11190802A"                      
                                    ,"SRR11190792A"                      
                                    ,"SRR11190796A"                      
                                    ,"SRR11190797A"                      
                                    ,"SRR11190795A"                      
                                    ,"SRR11603183A"                      
                                    ,"SRR11190801A"                      
                                    ,"SRR11190798A"                      
                                    ,"SRR11190799A"                      
                                    ,"SRR11190791A"                      
                                    ,"SRR11190800A"                      
                                    ,"SRR11603182A"                      
                                    ,"SRR11603184A"                      
                                    ,"LC128411"                          
                                    ,"SRR11603190A"                      
                                    ,"SRR11603186A"                      
                                    ,"SRR11603187A"                      
                                    ,"SRR11603189A"                      
                                    ,"SRR11603191A"                      
                                    ,"SRR11190793A"                      
                                    ,"Schlumbergera_truncata_15H05_pol"  
                                    ,"Schlumbergera_truncata_15H02_sty"  
                                    ,"Schlumbergera_truncata_15H03_sty_a"
                                    ,"Schlumbergera_truncata_15H03_pol"  
                                    ,"Schlumbergera_truncata_15H03_sty_b"
                                    ,"Schlumbergera_truncata_19JSF_sty"  
                                    ,"Schlumbergera_truncata_15H04_sty"  
                                    ,"Schlumbergera_truncata_15H04_pol"  
                                    ,"Schlumbergera_truncata_15H04_pet"  
                                    ,"Schlumbergera_truncata_15H06_pol"  
                                    ,"Schlumbergera_truncata_15H06_sty"  
                                    ,"JF937699"                          
                                    ,"KX883791"), "node")
CVX<- extract.clade(rerooted.zero, node=CVX.og, root.edge = 0, collapse.singles = TRUE, 
                     interactive=F)
plot(CVX)
edgelabels(CVX$edge.length, bg="grey", col="black", font=1)
CVX$edge.length
