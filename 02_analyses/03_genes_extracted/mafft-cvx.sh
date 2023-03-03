#!/bin/bash
#quick script for running mafft on cvx stuff

mafft --auto orf1.fasta > orf1-mafft.fasta
mafft --auto orf2.fasta > orf2-mafft.fasta
mafft --auto orf3.fasta > orf3-mafft.fasta
mafft --auto orf4.fasta > orf4-mafft.fasta
mafft --auto orf5.fasta > orf5-mafft.fasta
mafft --auto trimmed_complete_gb_and_srr.fasta > trimmed_complete_gb_and_srr-mafft.fasta