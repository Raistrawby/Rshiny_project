library(msigdbr)
library(clusterProfiler)

get_motifs_db <- function(org) {
  dicOrg = c("hsa" = "Homo sapiens")
  msigdbr(species = dicOrg[org], category = "C3")
  
}

get_motifs_gsea <- function(geneList, db) {
  GSEA(
    geneList,
    TERM2GENE = db
  )
}

get_motifs_sea <- function(geneList, db) {
  enricher(
    geneList,
    TERM2GENE = db
  )
}

data = readFile("", TRUE, "SYMBOL", org.Hs.eg.db)
db = get_motifs_db("hsa")
filter_db = db[,c("gs_name", "entrez_gene")]

geneList = get_geneList(data, 1)
gsea = get_motifs_gsea(geneList$GSEA, filter_db)

sea = get_motifs_sea(names(geneList$SEA), filter_db)
