source("./src/server/GSEA_SEA.R")

library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(ggplot2)
library(ggupset)

# GSEA ###############################################################
gse_analysis <- function(data, method, ontology_gse){
  gse <- gseGO(geneList=data$GSEA, 
               ont = ontology_gse, 
               keyType = "ENTREZID", 
               pvalueCutoff = 1,
               OrgDb = org.Hs.eg.db,
               pAdjustMethod=method)
  return(gse)
}

# SEA ################################################################
sea_analysis <- function(data, method, ontology_sea){
  go_enrich <- enrichGO(gene = names(data$SEA),
                        OrgDb = org.Hs.eg.db, 
                        keyType = "ENTREZID",
                        ont = ontology_sea,
                        pvalueCutoff = 1, 
                        qvalueCutoff = 1,
                        pAdjustMethod=method)
  return(go_enrich)
}

# PLOT ###############################################################
display_goplot <- function(result_object, title, padj) {
  result_object = filter_by_padj(result_object, padj)
  validate(
    need(nrow(result_object@result) > 0, "No Data to show")
  )
  goplot(result_object, showCategory = 10, title=title)
}
