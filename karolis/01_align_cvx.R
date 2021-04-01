library(DECIPHER)

unal.f <- '../data/genbank_kr_consensus_extraction_unal.fasta'
al.f <- '../data/genbank_kr_consensus_extraction_al.fasta'
unal.dna <- readDNAStringSet(unal.f)

al.dna <- AlignSeqs(
  unal.dna,
  guideTree = NULL,
  iterations = 100,
  refinements = 0,
  gapOpening = c(-18, -16),
  gapExtension = c(-2, -1),
  # levels = c(0.9, 0.7, 0.7, 0.4, 10, 5, 5, 2),
  #         AA   AA   NT   NT
  levels=c(0.0, 0.0, 0.0, 0.0, 1, 5, 5, 2),
  restrict=c(-1e1000, 1e1000, 1e1000),
  processors = 4,
  verbose = TRUE)

# BrowseSeqs(al.dna, highlight=1)

Biostrings::writeXStringSet(al.dna, al.f)
