cld.node.names <- c('')

clade.colors <- rgb(

  #       oth  sol  rub  pla  rut  cac  pru  mal
    red=c(000, 230, 086, 204, 180, 000, 213, 000),
  green=c(000, 159, 158, 121, 180, 158, 094, 114),
   blue=c(000, 000, 204, 167, 066, 115, 000, 178),

  alpha=rep(255, 8), maxColorValue=255, names=c(0, cld.node.names))


cld.nodes <- function(tree.dat, tree.tbl) {
  cld.cvxa <- MRCA(tree.dat, (tree.tbl %>% filter(group=='Cactus Virus X Variant A'))$label)
  cld.cvxb <- MRCA(tree.dat, (tree.tbl %>% filter(group=='Cactus Virus X Variant B'))$label)
  cld.opvx <- MRCA(tree.dat, (tree.tbl %>% filter(group=='Opuntia Virus X'))$label)
  cld.pvx <- MRCA(tree.dat, (tree.tbl %>% filter(group=='Pitaya Virus X'))$label)
  cld.svx <- MRCA(tree.dat, (tree.tbl %>% filter(group=='Schlumbergera Virus X'))$label)
  cld.zyvxb <- MRCA(tree.dat, (tree.tbl %>% filter(group=='Zygocactus Virus X Variant B1'))$label)
  
  cld.nodes <- c(cld.cvxb, cld.cvxb, cld.opvx, cld.pvx, cld.svx,
                 cld.zyvxb)

  names(cld.nodes) <- cld.node.names

  return(cld.nodes)
}

font.default <- 'Helvetica'
