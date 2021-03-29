library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library("pathview")

get_genelist <- function(data, organism, id_source, OrgDb) {
  conv <- bitr(data$X,
               fromType = id_source,
               toType = "ENTREZID",
               OrgDb = OrgDb)
  
  mergedData <- merge(data, conv, by.x = c("X"),
                      by.y = c("SYMBOL"))
  
  mergedData <-
    mergedData[order(mergedData$log2FoldChange, decreasing = T),]
  
  geneList = mergedData$log2FoldChange
  names(geneList) = mergedData$ENTREZID
  
  return(geneList)
}

get_KEGG_GSEA <- function(geneList, organism, pvalueCutoff = 0.05) {
  return(
    gseKEGG(
      geneList     = geneList,
      organism     = organism,
      nPerm        = 1000,
      minGSSize    = 120,
      pvalueCutoff = pvalueCutoff,
    )
  )
}

get_KEGG_site <- function(KEGGObject, pathway) {
  return(browseKEGG(KEGGObject, pathway))
}

get_KEGG_table <- function(kegg) {
  kegg_result = kegg@result
  kegg_result$URL = paste0(
    "<a href=https://www.kegg.jp/kegg-bin/show_pathway?",
    kegg_result$ID,
    " target='_blank'>",
    kegg_result$ID,
    "</a>"
  )
  selected_columns = c("URL",
                       "Description",
                       "enrichmentScore",
                       "pvalue",
                       "p.adjust",
                       "rank")
  return(kegg_result[, selected_columns])
}

get_KEGG_dotplot <- function(kegg, nbCat) {
  return(dotplot(kegg, showCategory = nbCat) + ggtitle("Dotplot for KEGG Enrichment (GSEA)"))
}

get_KEGG_ridgeplot <- function(kegg, nbCat) {
  return(
    ridgeplot(kegg, showCategory = nbCat) + ggtitle("RidgePlot for KEGG Enrichment (GSEA)")
  )
}


get_pathway_image <- function(geneList,
                              pathwayid, organism) {
  pathview(gene.data  = geneList,
           pathway.id = pathwayid,
           species    = organism)
  
  list(
    src = paste0(pathwayid, ".pathview.png"),
    contentType = 'image/png',
    width = "100%"
  )
}