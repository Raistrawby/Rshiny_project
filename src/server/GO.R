library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(ggplot2)
library(ggupset)


# GSEA ###############################################################
gse_analysis <- function(data, id_source){
  gse <- gseGO(geneList=data$GSEA, 
               ont ="CC", 
               keyType = "ENTREZID",
               minGSSize = 100, 
               maxGSSize = 500, 
               pvalueCutoff = 0.05, 
               verbose = FALSE, 
               OrgDb = org.Hs.eg.db, 
               pAdjustMethod = "none")
  return(gse)
}

# SEA ################################################################
sea_analysis <- function(data, id_source){
  go_enrich <- enrichGO(gene = names(data$SEA),
                        universe = names(data$GSEA),
                        OrgDb = org.Hs.eg.db, 
                        keyType = "ENTREZID",
                        readable = T,
                        ont = "CC",
                        pvalueCutoff = 0.05, 
                        qvalueCutoff = 0.10)
  return(go_enrich)
}

# PLOT ###############################################################
display_gseplot <- function(result){
  gseaplot2(result, title = "GSEA plot", geneSetID = 1)
}

display_ridgeplot <- function(result){
  ridgeplot(result) + labs(x = "Ridgeplot - Enrichment distribution")
}

display_dotplot <- function(result){
  dotplot(result, orderBy = "x")
}

display_barplot <- function(result){
  barplot(result, 
          drop = TRUE, 
          showCategory = 10, 
          title = "Barplot",
          font.size = 10)
}

display_upsetplot <- function(result) {
  upsetplot(result)
}
