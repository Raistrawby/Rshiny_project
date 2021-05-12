library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(ggplot2)
library(ggupset)


# GSEA ###############################################################
gse_analysis <- function(data, id_source){
  gse <- gseGO(geneList=data$GSEA, 
               ont ="BP", 
               keyType = "ENTREZID", 
               pvalueCutoff = 1,
               OrgDb = org.Hs.eg.db,)
  return(gse)
}

# SEA ################################################################
sea_analysis <- function(data, id_source){
  go_enrich <- enrichGO(gene = names(data$SEA),
                        OrgDb = org.Hs.eg.db, 
                        keyType = "ENTREZID",
                        ont = "BP",
                        pvalueCutoff = 1, 
                        qvalueCutoff = 1)
  return(go_enrich)
}

# PLOT ###############################################################
display_goplot <- function(result, title) {
  goplot(result, showCategory = 10, title=title)
}
