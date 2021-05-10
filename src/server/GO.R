library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(ggplot2)
library(ggupset)

get_genelist <- function(data, organism, id_source, OrgDb){
    conv <- bitr(data$X,
                 fromType=id_source,
                 toType= "ENTREZID",
                 OrgDb=OrgDb)
  mergedData <- merge(data, conv, by.x=c("X"), by.y=c("SYMBOL"))
  mergedData <- mergedData[order(mergedData$log2FoldChange, decreasing=T),]
  geneList <- mergedData$log2FoldChange
  names(geneList) <- mergedData$ENTREZID

  return(geneList)
}

# GSEA ###############################################################
gse_analysis <- function(data, id_source){
  gene_list <- get_genelist(data, "dme", id_source, "org.Hs.eg.db")
  gse <- gseGO(geneList=gene_list, 
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
  gene_list <- get_genelist(data, "dme", id_source, "org.Hs.eg.db")
  sig_genes_df = subset(data, padj < 0.05)
  genes <- get_genelist(sig_genes_df, "dme", id_source, "org.Hs.eg.db")
  genes <- na.omit(genes)
  genes <- names(genes)[abs(genes) > 0]
  go_enrich <- enrichGO(gene = genes,
                        universe = names(gene_list),
                        OrgDb = org.Hs.eg.db, 
                        keyType = "ENTREZID",
                        readable = T,
                        ont = "CC",
                        pvalueCutoff = 0.05, 
                        qvalueCutoff = 0.10)
  return(go_enrich)
}

#data = read.csv("./data/donnee2.csv")
#gse <- gse_analysis(data, "SYMBOL")
#sea <- sea_analysis(data, "SYMBOL")
#gsea_plot(gse)
#diplay_ridgeplot(gse)
#display_barplot(sea)

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


