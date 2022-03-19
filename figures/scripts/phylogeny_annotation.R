#at, 2-9-22, for cvx
#Notes:S4 objects and their slots can be accessed like this: "tree@example". 
load("objects.for.phylo.RData")
ls()
cols <- c(no='black', yes='red')

#tree visualization:
par(mar = c(0, 0, 0, 0))
p <- ggtree(cvx.tree.phylo.treedata.joined, ladderize=T, layout="rectangular",
           aes( family="Helvetica"), show.legend=FALSE)+
  #geom_tippoint(aes(color=new), size=1) + 
  scale_color_manual(values=cols) + 
  #virus name tip labels
  geom_tiplab(aes(color=new), align=F, linetype="dotted", 
               size=3, offset=0.1, hjust=0.2) +
  #host tip labels:
  geom_tiplab(aes(color=new, label=host, subset = !is.na(host)), align=T, linetype=NA, 
               size=4, offset=0.4, hjust=0)+
  geom_treescale(x=0.3, y=50,width=0.25, fontsize=4, linesize=1, offset=2, color='black', label='substitutions per site', offset.label=2)
p
#Save to pdf format if desired
filename <- "phylo_formal_tax.pdf"
ggsave(filename,width = 50, height = 50, units = "cm")
rn <- as.data.frame(heatmapData[3])
heatmapData <- as.data.frame(sapply(host.info.details, as.character))
rownames(heatmapData) <- rn$Name_updated
heatmap.colours <- c("white","grey","seagreen3","darkgreen",
                     "green","brown","tan","red","orange",
                     "pink","magenta","purple","blue","skyblue3",
                     "blue","skyblue2")
gheatmap(p, heatmapData[c(6,7,8)], colnames_angle=90, colnames_offset_y = 1, 
         hjust=0.3, offset=0.7, width=0.2)
ggsave("treewbars_circ.pdf",width = 50, height = 50, units = "cm")

#############batch creation code begins below
#Load metadata if needed, handy function to be used within larger function
reload.metadata <- function(){
  host.info.details <<- read.csv(host.info.loc, stringsAsFactors = FALSE)
  print("Metadata file loaded")
  reload.metadata()
  getwd()}
#optional long, clunky function to systematically create phylogenies for each gene.
gene.phylos <- function(namevector, locvector) {
  reload.metadata()
  for (i in 1:length(namevector)){
    cvx.tree.phylo.treedata <- read.iqtree(locs[1])
    cvx.tree.phylo.treedata <- read.iqtree(locvector[i])
    treename <- namevector[i]
    #  treetempphylo <- as.phylo(treetemp)
    
    print(namevector[i])
    #join tree and metadata
    cvx.tree.phylo.treedata@phylo <- ape::root(cvx.tree.phylo.treedata@phylo, outgroup=c("D29630.1"), resolve.root=TRUE)
    cvx.tree.phylo.treedata
    cvx.tree.phylo.treedata.joined <- as.treedata(dplyr::left_join(as_tibble(cvx.tree.phylo.treedata), as_tibble(host.info.details), by=c("label"= "Name_updated")))
    cvx.tree.phylo.treedata.joined@phylo <- cvx.tree.phylo.treedata@phylo
    par(mar = c(0, 0, 0, 0))
    ggtree(cvx.tree.phylo.treedata.joined, ladderize=T, aes(color=formal_tax, family="Helvetica"), show.legend=FALSE)+
      #host tip labels:
      geom_tiplab(aes(label=host, subset = !is.na(host)), linetype="dotted", align=T, fontsize=3, na.rm=F, 
                  #use for all trees:
                  offset=0.8, 
                  #use for just the full tree:
                  #offset=0.3,
                  fontface=3)+
      
      #virus name tip labels:
      geom_tiplab(aes(), geom="label",fontsize=3, fill="white", offset=0.1,family='Helvetica', align=F, label.size = 0)+
      
      #scale
      geom_treescale(x=0.25, y=60, width=0.25, fontsize=8, linesize=1, offset=1, color='black', label='substitutions per site', offset.label=-1)+
      #node labels/bootstrap labels:
      geom_text2(aes(subset = !isTip , label=label), nudge_x = 0.025, size=3)+
      xlim(0,4.5)+
      
      #newness tip labels:
      geom_tiplab(aes(label=new),size=10, color="black", family='Helvetica', align=T, na.rm=F, offset=0.26,vjust=0.8, linetype="blank", fontface=1)+
      #group labels
      scale_color_manual( name="Group", values=c("gray50", 
                                                 "#0072B2",
                                                 "#3FB13A", 
                                                 #"#BE81EF",
                                                 "#B39B00", 
                                                 "#E67E67", 
                                                 "#EC6DC4", 
                                                 "grey") )+
      theme(legend.position = c(0.1,0.9),
            legend.key.size = unit(2, 'cm'),
            legend.text = element_text(size = 20))
    
    #Save to pdf format
    filename = paste(namevector[i],"_tr_formal_tax.pdf",sep="")
    ggsave(filename,width = 70, height = 50, units = "cm")
  }
}
gene.phylos(names,locs)