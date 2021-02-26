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
    mergedData[order(mergedData$log2FoldChange, decreasing = T), ]
  
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

get_pathway_image <- function(geneList, pathwayid, organism) {
  pathview(
    gene.data  = geneList,
    pathway.id = pathwayid,
    species    = organism,
    limit      = list(gene = max(abs(geneList)), cpd = 1)
  )
}

geneList = get_genelist(data, "hsa", "SYMBOL", org.Hs.eg.db)
kegg = get_KEGG_GSEA(geneList, 'hsa')
site = get_KEGG_site(kegg, 'hsa05164')
image = get_pathway_image(geneList, 'hsa05164', 'hsa')
image
