#at, 2-9-22, for cvx
#Notes:S4 objects and their slots can be accessed like this: "tree@example". 
load("objects.for.phylo.RData")
ls()
cols <- c(no='black', yes='red')

######CIRCULAR tree visualization:####
par(mar = c(0, 0, 0, 0))
p <- ggtree(cvx.tree.phylo.treedata.joined, layout="circular",
           aes(family="Helvetica"), show.legend=FALSE)+
  scale_color_manual(values=cols) + 
  #virus name tip labels
  geom_tiplab(aes(color=new), align=F, linetype="dotted", 
               size=3, offset=0) +
  #host tip labels:
  geom_tiplab(aes(color=new, label=host, subset = !is.na(host)), align=T, linetype=NA, 
               size=3, offset=0.4, hjust=0)+

 # geom_treescale(x=0.3, y=50,width=0.25, fontsize=4, linesize=1, offset=2, color='black', label='substitutions per site', offset.label=2)
  geom_text2(aes(label=UFboot),size = 1, hjust=0.5)
p
nodes.tocol <- c(109, 114)
MRCA(cvx.tree.phylo.treedata.joined, c("LC107517", "KU159093"))
cp <- ggtree::collapse(p, node=109)
cp <- ggtree::collapse(cp, node=114)
cp
#Save to pdf format if desired
#filename <- "phylo_formal_tax.pdf"
#ggsave(filename,width = 50, height = 50, units = "cm")
heatmapData <- as.data.frame(sapply(host.info.details, as.character))
rn <- as.data.frame(heatmapData[3])
rownames(heatmapData) <- rn$Name_updated
heatmap.colours <- c("white","grey","seagreen3","darkgreen",
                     "green","red","orange",
                     "pink","magenta","purple","blue","skyblue3",
                     "blue","skyblue2")
gheatmap(cp, heatmapData[c(6,7, 8, 12, 10,11)], colnames_angle=90, colnames_offset_y = -2, 
         hjust=0.3, offset=1.3, width=0.5)
ggsave("tree_circular_collapsed_nodes.pdf",width = 50, height = 50, units = "cm")


########RECTANGULAR tree visualization:####
par(mar = c(0, 0, 0, 0))
p <- ggtree(cvx.tree.phylo.treedata.joined.dropped, ladderize=T, layout="rectangular",
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
#geom_text(aes(label=node), hjust=-.3)
p
#Save to pdf format if desired
#filename <- "phylo_formal_tax.pdf"
#ggsave(filename,width = 50, height = 50, units = "cm")
heatmapData <- as.data.frame(sapply(host.info.details, as.character))
rn <- as.data.frame(heatmapData[3])
rownames(heatmapData) <- rn$Name_updated
heatmap.colours <- c("white","grey","seagreen3","darkgreen",
                     "green","red","orange",
                     "pink","magenta","purple","blue","skyblue3",
                     "blue","skyblue2")
gheatmap(p, heatmapData[c(6,7, 8, 12, 10,11)], colnames_angle=90, colnames_offset_y = 1, 
         hjust=0.3, offset=1.3, width=0.2)
ggsave("tree_rect_dropped.pdf",width = 50, height = 50, units = "cm")

#############batch creation code begins below####
#Load metadata if needed, handy function to be used within larger function
reload.metadata <- function(){
  host.info.details <<- read.csv(host.info.loc, stringsAsFactors = FALSE)
  print("Metadata file loaded")
  reload.metadata()
  getwd()}
#optional long, clunky function to systematically create phylogenies for each gene.
gene.phylos <- function(namevector, locvector) {
  for (i in 1:length(namevector)){
    #cvx.tree.phylo.treedata <- read.iqtree(locs[1])
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
    ggtree(cvx.tree.phylo.treedata.joined, ladderize=T, aes(family="Helvetica"), show.legend=FALSE)+
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
      geom_nodelab(aes(label = UFboot), nudge_x = 0.025)+
      xlim(0,4.5)
    
    #Save to pdf format
    filename = paste(namevector[i],"_tr.pdf",sep="")
    ggsave(filename,width = 70, height = 50, units = "cm")
  }
}
gene.phylos(names,locs)
