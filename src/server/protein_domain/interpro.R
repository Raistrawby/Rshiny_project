library(clusterProfiler)

get_interpro_db <- function(entrezid, specie) {
  ensembl = useEnsembl(biomart = "ensembl", host = "uswest.ensembl.org")
  dataset = searchDatasets(mart = ensembl, pattern = specie)
  ensembl <-
    useEnsembl(biomart = "genes",
               dataset = dataset$dataset,
               host = "uswest.ensembl.org")
  
  BM_DB <-
    getBM(
      attributes = c('entrezgene_id', 'interpro', 'interpro_description'),
      mart = ensembl,
      filters = "entrezgene_id",
      values = entrezid,
      uniqueRows = TRUE
    )
  BM_DB = BM_DB[BM_DB$interpro != "", ]
  
  return(BM_DB)
}

get_interpro_gsea <- function(geneList, db, method) {
  gsea = GSEA(
    geneList,
    TERM2GENE = db[, c('interpro', 'entrezgene_id')],
    pvalueCutoff = 1,
    pAdjustMethod = method
  )
  
  # Replace description by description in db
  # Use unique because 1 interpro ID = n entrezid
  gsea@result$Description = merge(
    x = gsea@result,
    y = unique(db[, c("interpro", "interpro_description"),]),
    by.x = "ID",
    by.y = "interpro"
  )$interpro_description
  return(gsea)
}

get_interpro_sea <- function(geneList, db, method) {
  sea = enricher(
    geneList,
    TERM2GENE = db[, c('interpro', 'entrezgene_id')],
    pvalueCutoff = 1,
    qvalueCutoff = 1,
    pAdjustMethod = method
  )
  # Replace description by description in db
  # Use unique because 1 interpro ID = n entrezid
  sea@result$Description = merge(
    x = sea@result,
    y = unique(db[, c("interpro", "interpro_description"),]),
    by.x = "ID",
    by.y = "interpro"
  )$interpro_description
  return(sea)
}