#this is a genome visualization for cvx
#made by at, 4/19/2022
#5/23/22
library(ggplot2)
library(Gviz)
library(IRanges) 
regionsOfInterest <- IRanges(start = c(0, 6614), width = 6614) 
names(regionsOfInterest) <- c("Cactus Virus X Complete Genome NC_002815") 
regionsOfInterest

toGroup <- GRanges(seqnames="chr1", 
                   IRanges( 
                     start=c(84,4716,5368,5630,5840,1427,2945), 
                     end=c(4716,5405,5700,5824,6514,1831,3163) 
                   )) 
names(toGroup) <- seq(1,7) 
toGroup

strand(toGroup) <- c("+","+","+","+","+","+","+") 
annoT <- AnnotationTrack(toGroup, shape="box", rotation.group=90,
                         group = c("RdRp", 
                                   "TGB1", 
                                   "TGB2",
                                   "TGB3",
                                   "Coat protein",
                                   "ORF6",
                                   "ORF7"
                                   )) 
gtrack <- GenomeAxisTrack()
plotTracks(list(gtrack, annoT), add35=TRUE,groupAnnotation="group")
