#!/bin/bash
#note that duplicate sequences were manually removed in the files
iqtree -s orf1-mafft.fasta -bb 1000
iqtree -s orf2-mafft.fasta -bb 1000
iqtree -s orf3-mafft.fasta -bb 1000
iqtree -s orf4-mafft.fasta -bb 1000
iqtree -s orf5-mafft.fasta -bb 1000